
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';

import '../../../helper/LocalDb/floor/database.dart';
import '../../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../../helper/LocalDb/floor/recent_view_controller.dart';

class ItemCard extends StatelessWidget {
  double? imageSize;

  final Products? product;

  ItemCard({this.product, this.imageSize});

  @override
  @override
  Widget build(BuildContext context) {
    imageSize ??= (AppSizes.width / 2.6) - AppSizes.linePadding;

    return GestureDetector(
      onTap: () {
        AppDatabase.getDatabase().then(
              (value) => value.recentProductDao
              .insertRecentProduct(
            RecentProduct(
              templateId: product?.templateId.toString() ?? '',
              name: product?.name,
              priceUnit: product?.priceUnit,
              priceReduce: product?.priceReduce,
              image: product?.thumbNail ?? '',
            ),
          )
              .then(
                (value) =>
                RecentViewController.controller.sink.add(product?.templateId?.toString() ?? ''),
          ),
        );

        Navigator.of(context).pushNamed(productPage,
            arguments: getProductDataMap(
                product?.name ?? '', product?.templateId.toString() ?? ''));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: MobikulTheme.lightGrey,
            ),
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.all(Radius.circular(AppSizes.linePadding))
        ),
        margin: EdgeInsets.symmetric(horizontal: AppSizes.linePadding/2, vertical: AppSizes.linePadding/2),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(AppSizes.imageRadius),
              child: ImageView(
                fit: BoxFit.fill,
                url: product?.thumbNail,
                width: imageSize! - AppSizes.normalPadding,
                height: imageSize! - AppSizes.normalPadding,
              ),
            ),
            SizedBox(
              width: imageSize,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: AppSizes.imageRadius,
                    // top: AppSizes.imageRadius,
                    right: AppSizes.imageRadius),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(product?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Visibility(
                          visible: (product?.priceReduce ?? '').isNotEmpty,
                          child: Text(product?.priceUnit ?? '',
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(decoration: TextDecoration.lineThrough),
                          )),
                      Visibility(
                        visible: (product?.priceReduce ?? '').isNotEmpty,
                        child: const SizedBox(
                          height: 2.0,
                        ),
                      ),
                      Text(
                        (product?.priceReduce ?? '').isNotEmpty
                            ? product?.priceReduce ?? ''
                            : product?.priceUnit ?? '',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),

                      const SizedBox(
                        height: 2.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
