import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/menu_images.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_route_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/models/ProfileMenuItem.dart';

Widget marketplaceProfileMenu(
  Function logoutFunction,
  AppLocalizations? _localizations,
) {
  List<ProfileMenuItems> menuItems = [];
  menuItems.clear();
  menuItems.add(ProfileMenuItems(
      id: 10,
      title: _localizations?.translate(MarketplaceStringConstant.marketplace) ?? '',
      icon: AppImages.marketplaceIcon));
  if (AppSharedPref().getUserData()?.isSeller ?? false) {
    menuItems.add(ProfileMenuItems(
        id: 11,
        title:
            _localizations?.translate(MarketplaceStringConstant.sellerDashboard) ?? '',
        icon: AppImages.sellerDashboard));
    menuItems.add(ProfileMenuItems(
        id: 12,
        title: _localizations?.translate(MarketplaceStringConstant.sellerProfile) ?? '',
        icon: AppImages.sellerProfileIcon));
    menuItems.add(ProfileMenuItems(
        id: 13,
        title: _localizations?.translate(MarketplaceStringConstant.sellerOrder) ?? '',
        icon: AppImages.ordersIcon));
    menuItems.add(ProfileMenuItems(
        id: 14,
        title: _localizations?.translate(MarketplaceStringConstant.askToAdmin) ?? '',
        icon: AppImages.chatImage));
  }
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
          child: marketplaceProfileTiles(
              context,
              logoutFunction,
              menuItems[i].id,
              menuItems[i].title,
              menuItems[i].icon,
              _localizations),
        );
      });
}

Widget marketplaceProfileTiles(
  BuildContext context,
  Function logoutFunction,
  int id,
  String title,
  String icon,
  AppLocalizations? _localizations, {
  double iconWidth = AppSizes.buttonRadius,
  double? iconHeight = AppSizes.buttonRadius,
}) {
  return ListTile(
    onTap: () {
      callBack(context, id, _localizations);
    },
    horizontalTitleGap: 0,
    leading: Image.asset(
      icon,
      height: iconHeight,
      width: iconWidth,
      color: Theme.of(context).colorScheme.onPrimary,
    ),
    title: Text(title, style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.w700)),
  );
}

void callBack(BuildContext context, int id, AppLocalizations? _localizations) {
  switch (id) {
    case 11:
      //Seller Dashboard
      Navigator.of(context).pushNamed(sellerDashboard);
      break;
    case 12:
      // Seller Profile
      Navigator.of(context).pushNamed(sellerProfile, arguments: AppSharedPref().getUserData()?.customerId );
      break;
    case 13:
      // Seller Order
      Navigator.of(context).pushNamed(sellerOrder, arguments: '');
      break;
    case 14:
      // Ask To Admin
      Navigator.of(context).pushNamed(askToAdmin);
      break;
    case 10:
      // MarketPlace
      Navigator.of(context).pushNamed(marketplaceScreen);
      break;
    default:
  }
}
