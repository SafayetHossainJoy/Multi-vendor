
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/SearchScreenModel.dart';

import '../../../helper/LocalDb/floor/database.dart';
import '../../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../../helper/LocalDb/floor/recent_view_controller.dart';

Widget suggestionList(
    SearchScreenModel? searchSuggestionModel, BuildContext context, AppLocalizations? _localizations) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.extraPadding),
      child: Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.all(AppSizes.extraPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _localizations?.translate(AppStringConstant.relatedProduct) ??
                  '',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: AppSizes.extraPadding,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print(searchSuggestionModel?.products?[index].toJson());
                      AppDatabase.getDatabase().then(
                            (value) => value.recentProductDao
                            .insertRecentProduct(
                          RecentProduct(
                            templateId: searchSuggestionModel?.products?[index].templateId.toString(),
                            name: searchSuggestionModel?.products?[index].name,
                            priceUnit: searchSuggestionModel?.products?[index].priceUnit,
                            priceReduce: searchSuggestionModel?.products?[index].priceReduce,
                            image: searchSuggestionModel?.products?[index].thumbNail,
                          ),
                        )
                            .then(
                              (value) => RecentViewController.controller.sink
                              .add(searchSuggestionModel?.products?[index].productId.toString()),
                        ),
                      );

                      Navigator.pushNamed(context, productPage,
                          arguments: getProductDataMap(
                              searchSuggestionModel?.products?[index].name ??
                                  "",
                              (searchSuggestionModel
                                  ?.products?[index].templateId ??
                                  "")
                                  .toString()));
                    },
                    child: Row(
                      children: [
                        ImageView(
                          url: searchSuggestionModel
                              ?.products?[index].thumbNail,
                          height: AppSizes.width / 7,
                          width: AppSizes.width / 7,
                        ),
                        Expanded(
                          child: Container(
                            margin:
                            const EdgeInsets.all(AppSizes.imageRadius),
                            padding:
                            const EdgeInsets.all(AppSizes.imageRadius),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  searchSuggestionModel
                                      ?.products?[index].name ??
                                      "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: AppSizes.imageRadius / 2,
                                ),
                                Text(searchSuggestionModel
                                    ?.products?[index].priceUnit ??
                                    '')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  height: AppSizes.genericPadding,
                ),
                itemCount: searchSuggestionModel?.products?.length ?? 0),
          ],
        ),
      ),
    ),
  );
}