
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/models/SocialLoginModel.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_bloc.dart';
import 'package:flutter_project_structure/screens/signin_signup/view/social_signin.dart';

class SocialLogin extends StatelessWidget {
  final SigninSignupScreenBloc? bloc;
   SocialLogin(this.bloc, {Key? key}) : super(key: key);

  SplashScreenModel? model = AppSharedPref().getSplashData();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.extraPadding),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (Platform.isIOS)
            GestureDetector(
                onTap: () async {
                  const platform = MethodChannel(AppConstant.channelName);
                  var result = await platform.invokeMethod("appleSignin");
                  print("appleSignin===> " + result.toString());
                  if (result != null) {
                    bloc?.add(const LoadingEvent());
                    var request = SocialLoginModel(
                        firstName: result["firstname"],
                        lastName: result["lastname"],
                        email: result["email"],
                        id: result['id'],
                        photoUrl: '',
                        serverAuthCode: result['id'],
                        authProvider: "GMAIL");

                    bloc?.add(SocialLoginEvent(request));
                    bloc?.emit(LoadingState());
                  }
                },
                child: SizedBox(
                  child: Image.asset((Theme.of(context).brightness == Brightness.light)? "lib/assets/images/ic_apple.png" : "lib/assets/images/ic_apple_dark.png"),
                  height: 37,
                  width: 37,
                )
            ),
          SizedBox(width: 08,),
          model?.allowGmailSign ?? true
              ? const SizedBox(width: AppSizes.extraPadding)
              : Container(),
          model?.allowGmailSign ?? true
              ? GestureDetector(
                  onTap: () async {
                    var result = await socialSignIn.handleGoogleSignIn();
                    bloc?.add(const LoadingEvent());

                    var request = SocialLoginModel(
                        firstName: result?.displayName,
                        lastName: '',
                        email: result?.email,
                        id: result?.id,
                        photoUrl: result?.photoUrl,
                        serverAuthCode: result?.serverAuthCode,
                        authProvider: "GMAIL");
                        if (result != null) {
                          bloc?.add(SocialLoginEvent(request));
                          bloc?.emit(LoadingState());
                        }
                    socialSignIn.signout();
                  },
                  child: SizedBox(
                    child: Image.asset("lib/assets/images/ic_google.png"),
                    height: 50,
                    width: 50,
                  ))
              : Container(),
          model?.allowGmailSign ?? true
              ? const SizedBox(width: AppSizes.extraPadding)
              : Container(),
          // const SizedBox(width: 12,),
          model?.allowFacebookSign ?? true
              ? GestureDetector(
                  onTap: () async {
                    var result = await socialSignIn.handleFacebookSignIn();

                    var profile =
                        await socialSignIn.facebookLogin.getUserProfile();

                    if (result?.status == FacebookLoginStatus.success) {
                      var request = SocialLoginModel(
                          firstName: profile?.firstName,
                          lastName: profile?.lastName,
                          email:
                              await socialSignIn.facebookLogin.getUserEmail(),
                          id: profile?.userId,
                          authProvider: "FACEBOOK",
                          token: result?.accessToken?.token);

                      bloc?.add(SocialLoginEvent(request));
                      bloc?.emit(LoadingState());
                    }
                    socialSignIn.signout();
                  },
                  child: SizedBox(
                    child: Image.asset("lib/assets/images/ic_facebook.png"),
                    height: 50,
                    width: 50,
                  ))
              : Container()
        ],
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
