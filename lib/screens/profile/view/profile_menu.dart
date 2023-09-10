
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/menu_images.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/models/ProfileMenuItem.dart';
import 'package:flutter_project_structure/screens/profile/view/language_selection_bottomsheet.dart';
import '../../../helper/open_bottom_model_sheet.dart';

Widget profileMenu(AppLocalizations? _localizations,
    VoidCallback setState) {
  List<ProfileMenuItems> menuItems = [];
  menuItems.clear();
  if (AppSharedPref().getIfLogin() ?? false) {
    menuItems.add(ProfileMenuItems(
        id: 1,
        title: _localizations?.translate(AppStringConstant.dashboard) ?? '',
        icon: AppImages.dashboardIcon));
    menuItems.add(ProfileMenuItems(
        id: 2,
        title: _localizations?.translate(AppStringConstant.accountInfo) ?? '',
        icon: AppImages.accountInformationIcon));
    menuItems.add(ProfileMenuItems(
        id: 3,
        title: _localizations?.translate(AppStringConstant.addressBook) ?? '',
        icon: AppImages.addressBookIcon));
    menuItems.add(ProfileMenuItems(
        id: 4,
        title: _localizations?.translate(AppStringConstant.allOrders) ?? '',
        icon: AppImages.ordersIcon));
    menuItems.add(ProfileMenuItems(
        id: 5,
        title: _localizations?.translate(AppStringConstant.myWishlist) ?? '',
        icon: AppImages.wishlistIcon));
  } else {
    menuItems.add(ProfileMenuItems(
        id: 7,
        title: _localizations?.translate(AppStringConstant.signIn) ?? '',
        icon: AppImages.loginIcon));
  }
  menuItems.add(ProfileMenuItems(
      id: 8,
      title: _localizations?.translate(AppStringConstant.language) ?? '',
      icon: AppImages.translationIcon));
  menuItems.add(ProfileMenuItems(
      id: 9,
      title: _localizations?.translate(AppStringConstant.setting) ?? '',
      icon: AppImages.settingsIcon // need to change icon
      ));

  return ListView.builder(
      shrinkWrap: true,
      itemCount: menuItems.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, i) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: AppColors.lightGray,
                    width: 0.5)),
          ),
          child: profileTiles(context, menuItems[i].id,
              menuItems[i].title, menuItems[i].icon, _localizations, setState),
        );
      });
}

Widget profileTiles(
  BuildContext context,
  int id,
  String title,
  String icon,
  AppLocalizations? _localizations,
  VoidCallback setState, {
  double iconWidth = AppSizes.buttonRadius,
  double? iconHeight = AppSizes.buttonRadius,
}) {
  return ListTile(
    onTap: () {
      callBack(context, id, _localizations, setState);
    },

    leading: SizedBox(
      width: iconWidth,
      height: iconHeight,
      child: Center(
        child: Stack(
          children: [
            Image.asset(
              icon,
              height: iconHeight,
              width: iconWidth,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            if ((icon == AppImages.accountInformationIcon) &&
                (AppSharedPref().getSplashData()?.addons?.odooGdpr ?? false) &&
                !(AppSharedPref().getUserData()?.isEmailVerified ?? true))
              Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(8.5),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.priority_high,
                      size: 10,
                      color: AppColors.white,
                    )),
                  )),
          ],
        ),
      ),
    ),
    horizontalTitleGap: 0,

    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.w700),),
      ],
    ),
  );
}


void callBack(BuildContext context, int id,
    AppLocalizations? _localizations, VoidCallback setState) {
  switch (id) {
    case 1:
      //dashboard
      Navigator.of(context).pushNamed(dashboard).then((value) {
        print('callback method-------- profile tile');
        setState();});
      break;
    case 2:
      // account info
      Navigator.of(context).pushNamed(accountInfo).then((value) => setState);
      break;
    case 3:
      // address book
      Navigator.of(context).pushNamed(addressBook);
      break;
    case 4:
      // orders
      Navigator.of(context).pushNamed(orders, arguments: false);
      break;
    case 5:
      Navigator.of(context).pushNamed(wishlist);
      break;
    case 7:
      // login
      Navigator.of(context).pushNamed(loginSignup, arguments: false);
      break;
    case 8:
      // language
      showLanguageBottomSheet(context, _localizations);
      break;
    case 9:
      showSettingBottomSheet(context);
      // showSettingsBottomSheet(context, _localizations);
      break;
    default:
  }
}

Widget signOutTile(BuildContext context,AppLocalizations? _localizations, Function() logoutFunction){
  return ListTile(
    horizontalTitleGap: 0,
    leading: Image.asset(
      AppImages.logoutIcon,
      height: AppSizes.buttonRadius,
      width: AppSizes.buttonRadius,
      color: Theme.of(context).colorScheme.onPrimary,
    ),
    onTap: logoutFunction,
    title: Text(_localizations?.translate(AppStringConstant.signOut) ?? '',
        style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.w700)
    ),
  );
}