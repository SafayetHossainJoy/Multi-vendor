
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/database.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/entities/recent_product.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/recent_view_controller.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/app_string_constant.dart';
import '../../../../models/HomeScreenModel.dart';
import '../item_card.dart';
import '../product_item_full_width.dart';

Widget buildGridProduct(
    List<Products> products, AppLocalizations? _localizations,
    {String? url, bool isCatalog = false}) {
  //----------Will Call if type is AppConstant.productFixed
  return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (1 - (90 / AppSizes.width / 2)),
      ),
      itemCount: products.length.isEven ? products.length : products.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == products.length) {
          return isCatalog
              ? Container()
              : GestureDetector(
                  onTap: () {
                    print(products[index].toJson());
                    AppDatabase.getDatabase().then(
                      (value) => value.recentProductDao
                          .insertRecentProduct(
                            RecentProduct(
                              templateId: products[index].templateId.toString(),
                              name: products[index].name,
                              priceUnit: products[index].priceUnit,
                              priceReduce: products[index].priceReduce,
                              image: products[index].thumbNail,
                            ),
                          )
                          .then(
                            (value) => RecentViewController.controller.sink
                                .add(products[index].productId.toString()),
                          ),
                    );

                    Navigator.pushNamed(context, catalogPage,
                        arguments: getCatalogMap(
                          url!,
                          true,
                          "Catalog",
                          customerId: 0,
                        ));
                    print(url);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                        borderRadius: const BorderRadius.all(
                             Radius.circular(AppSizes.linePadding))),
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppSizes.linePadding / 2,
                        vertical: AppSizes.linePadding / 2),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.play_circle_outline),
                          const SizedBox(
                            height: AppSizes.imageRadius,
                          ),
                          Text(
                            _localizations
                                    ?.translate(AppStringConstant.viewAll) ??
                                "",
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                    ),
                  ),
                );
        } else {
          var data = products[index];
          return GestureDetector(
            onTap: () {
              print(data.toJson());
              AppDatabase.getDatabase().then(
                (value) => value.recentProductDao
                    .insertRecentProduct(
                      RecentProduct(
                        templateId: data.templateId.toString(),
                        name: data.name,
                        priceUnit: data.priceUnit,
                        priceReduce: data.priceReduce,
                        image: data.thumbNail,
                      ),
                    )
                    .then(
                      (value) => RecentViewController.controller.sink
                          .add(data.productId.toString()),
                    ),
              );
            },
            child: ItemCard(product: data),
          );
        }
      });
}

Widget buildHorizontalProduct(
    List<Products> products, AppLocalizations? _localizations,
    {String? url}) {
  //----------Will Call if type is AppConstant.productDefault
  return SizedBox(
    width: AppSizes.width.toDouble(),
    height: (AppSizes.width / 1.8),
    child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: (products.length.isOdd && (url != null))
            ? products.length + 1
            : products.length,
        itemBuilder: (BuildContext context, int index) {
          if ((index == products.length) && url != null) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, catalogPage,
                    arguments: getCatalogMap(
                      url,
                      true,
                      "Catalog",
                      customerId: 0,
                    ));
              },
              child: Container(
                height: ((AppSizes.width / 2.5) - 8) - 3,
                width: (AppSizes.width -
                        (AppSizes.linePadding + AppSizes.linePadding)) /
                    2.5,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                    borderRadius: const BorderRadius.all(
                        const Radius.circular(AppSizes.linePadding))),
                margin: const EdgeInsets.symmetric(
                    horizontal: AppSizes.linePadding / 2,
                    vertical: AppSizes.linePadding / 2),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.play_circle_outline),
                      const SizedBox(
                        height: AppSizes.imageRadius,
                      ),
                      Text(
                          _localizations
                                  ?.translate(AppStringConstant.viewAll) ??
                              "",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
              ),
            );
          } else {
            var data = products[index];
            return GestureDetector(
              onTap: () {},
              child: ItemCard(
                product: data,
                imageSize: (AppSizes.width -
                        (AppSizes.linePadding + AppSizes.linePadding)) /
                    2.5,
              ),
            );
          }
        }),
  );
}

Widget buildStaggered(List<Products> products) {
  //----------Will Call for random widgets
  List<Widget> customViews = [];
  for (int i = 0; i < products.length; i++) {
    if ((i + 1) % 3 == 0) {
      print("ewewfwe--Code3$i");
      customViews.add(SizedBox(
        height: (AppSizes.width / 1.9),
        width: AppSizes.width - (AppSizes.linePadding + AppSizes.linePadding),
        child: ProductItemFullWidth(
          product: products[i],
        ),
      ));
      i++;
    } else {
      if (i == 0) {
        continue;
      }
      print("ewewfwe--Code2$i----${i - 1}");
      customViews.add(Row(
        children: [
          SizedBox(
            width: AppSizes.width / 2 -
                (AppSizes.linePadding + AppSizes.linePadding),
            child: ItemCard(
              product: products[i - 1],
              imageSize: AppSizes.width / 2 -
                  (AppSizes.linePadding + AppSizes.linePadding),
            ),
          ),
          SizedBox(
            width: AppSizes.width / 2 -
                (AppSizes.linePadding + AppSizes.linePadding),
            child: ItemCard(
              product: products[i],
              imageSize: AppSizes.width / 2 -
                  (AppSizes.linePadding + AppSizes.linePadding),
            ),
          )
        ],
      ));
    }
  }
  return Column(children: customViews);
}

Widget buildStaggeredGrid(
    List<Products> products, AppLocalizations? _localizations) {
  if (products.length < 5) {
    var list = [
      buildHorizontalProduct(products, _localizations),
      buildGridProduct(products, _localizations),
      buildStaggered(products)
    ];
    return (list..shuffle()).first;
  } else {
    var totalWidth =
        AppSizes.width - ((AppSizes.imageRadius + AppSizes.imageRadius));
    var totalHeight = AppSizes.height / 1.2;
    var imageHeight = (AppSizes.height) / 1.9;
    return Row(
      children: [
        SizedBox(
          width: totalWidth * 0.6,
          child: Column(
            children: [
              SizedBox(
                height: totalHeight / 2,
                child: ItemCard(
                  product: products[0],
                  imageSize: imageHeight * 0.60,
                ),
              ),
              SizedBox(
                height: totalHeight / 2,
                child: ItemCard(
                  product: products[1],
                  imageSize: imageHeight * 0.60,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: totalWidth * 0.4,
          child: Column(
            children: [
              SizedBox(
                height: totalHeight / 3,
                child: ItemCard(
                  product: products[2],
                  imageSize: imageHeight / 3,
                ),
              ),
              SizedBox(
                height: totalHeight / 3,
                child: ItemCard(
                  product: products[3],
                  imageSize: imageHeight / 3,
                ),
              ),
              SizedBox(
                height: totalHeight / 3,
                child: ItemCard(
                  product: products[4],
                  imageSize: imageHeight / 3,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
