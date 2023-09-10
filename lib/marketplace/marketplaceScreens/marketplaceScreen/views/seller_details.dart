
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/rating_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_route_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstant/marketplace_arguments_map.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/MarketPlaceModel.dart';
import 'package:flutter_project_structure/screens/home/views/product_list_widgets/product_list_widgets.dart';

Widget sellerDetails(BuildContext context, AppLocalizations? localizations,
    SellersDetail? sellersDetail) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, sellerProfile, arguments: sellersDetail?.sellerId);
        },
        child: Container(
          color: AppColors.lightBlue,
          padding: const EdgeInsets.all(AppSizes.extraPadding),
          child: Row(
            children: [
              Container(
                  height: AppSizes.height / 8,
                  width: AppSizes.height / 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: MobikulTheme.accentColor, width: 2.0)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.height / 8),
                      child: ImageView(
                        url: sellersDetail?.sellerProfileImage,
                        fit: BoxFit.fill,
                      ))),
              const SizedBox(
                width: AppSizes.extraPadding,
              ),
              Column(
                children: [
                  Text(
                    sellersDetail?.name ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: AppSizes.imageRadius,
                  ),
                  Text(
                      "${sellersDetail?.productCount ?? ''} ${((sellersDetail?.productCount ?? 0) > 1) ? localizations?.translate(AppStringConstant.products) : localizations?.translate(MarketplaceStringConstant.product)}"),
                  RatingBar(
                    size: 18,
                    rating: sellersDetail?.averageRating,
                    color: AppColors.green,
                    borderColor: AppColors.lightGray,
                  )
                ],
              ),
              const Spacer(),
              commonButton(context, () {
                Navigator.pushNamed(context, catalogPage, arguments: catalogDataMap(25, 0, sellersDetail?.sellerId ?? 0, sellersDetail?.name ?? ''));
              },
                  localizations?.translate(AppStringConstant.viewAll) ?? '',
                  width: AppSizes.width / 6, borderRadius: 30)
            ],
          ),
        ),
      ),

      const SizedBox(height: AppSizes.linePadding,),
      Visibility(
        visible: sellersDetail?.sellerProducts?.products?.isNotEmpty ?? false,
          child: buildHorizontalProduct(sellersDetail?.sellerProducts?.products ?? [], localizations)),
      const SizedBox(height: AppSizes.linePadding,),

    ],
  );
}