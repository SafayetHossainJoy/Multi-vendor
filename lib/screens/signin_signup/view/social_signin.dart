
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SocialSignin {
  final _googleSignin = GoogleSignIn();
  final facebookLogin = FacebookLogin();
  Authprovider provider = Authprovider.none;

  Future<GoogleSignInAccount?> handleGoogleSignIn() async {
    try {
      var data = await _googleSignin.signIn();
      provider = Authprovider.gmail;
      print(data?.displayName);
      print(data?.serverAuthCode);
      print(data);
      print("account_info_data");
      return data;
    } catch (error, stk) {
      print(error);
      print(stk);
      return null;
    }
  }

  Future<FacebookLoginResult?> handleFacebookSignIn() async {
    try {
      var result = await facebookLogin.logIn(permissions: [
        FacebookPermission.email,
        FacebookPermission.publicProfile
      ]);
      print(result.status);
      print(await facebookLogin.accessToken);
      if ((await facebookLogin.isLoggedIn)) {
        print(await facebookLogin.getUserEmail());
      }
      provider = Authprovider.facebook;
      return result;
    } catch (error, stk) {
      print(stk);
      return null;
    }
  }

  void signout() async {
    switch (provider) {
      case Authprovider.facebook:
        facebookLogin.logOut();
        break;
      case Authprovider.gmail:
        _googleSignin.signOut();
        break;
      default:
        break;
    }
  }
}

enum Authprovider { facebook, gmail, none }

final socialSignIn = SocialSignin();
