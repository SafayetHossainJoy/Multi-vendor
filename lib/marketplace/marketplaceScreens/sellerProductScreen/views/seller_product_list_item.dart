
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerProductModel.dart';

Widget sellerProductListItem(BuildContext context,AppLocalizations? localizations, SellerProduct product ){
  return Container(
    color: Theme.of(context).dividerColor.withOpacity(0.03),
    // decoration: BoxDecoration(

        // border: Border.all(
        //   // color: Theme.of(context).dividerColor,
        // )),
    margin: const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(children: <Widget>[
          ImageView(
            url: product.thumbNail,
            height: (AppSizes.width /3 ),
          ),
          // Positioned(
          //     left: 0,
          //     top: 8,
          //     child: Container(
          //       color: Colors.green,
          //       child: const Padding(
          //         padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
          //         child: Text(
          //           AppStringConstant.newLabel,
          //           style: TextStyle(
          //             fontSize: 15.0,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ))
        ]),
        const SizedBox(
          width: AppSizes.imageRadius,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(localizations?.translate(MarketplaceStringConstant.product) ?? '', style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14),),
              const SizedBox(
                height: AppSizes.imageRadius / 2,
              ),

              Text(product.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge
              ),
              const SizedBox(
                height: AppSizes.imageRadius,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("${localizations?.translate(AppStringConstant.qty) ?? ''} : ", style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14),),

                  Text(
                      ((product.qty)?.toInt() ?? '').toString(),
                      style: Theme.of(context).textTheme.bodyText1
                  ),

                ],
              ),
              const SizedBox(
                height: AppSizes.imageRadius,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("${localizations?.translate(AppStringConstant.price) ?? ''} : ", style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14),),

                  Text(
                      product.priceUnit ?? '',
                      style: Theme.of(context).textTheme.bodyText1

                  ),

                ],
              ),
              const SizedBox(
                height: AppSizes.imageRadius ,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("${localizations?.translate(MarketplaceStringConstant.status) ?? ''} : ", style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14),),

                  Text(
                      (product.state ?? '').toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1

                  ),
                ],
              ),
              const SizedBox(
                height: AppSizes.imageRadius ,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}