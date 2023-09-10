
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/database.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/entities/recent_product.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/recent_view_controller.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';

import '../../../constants/arguments_map.dart';
import '../../../constants/route_constant.dart';

class RecentView extends StatefulWidget {
  const RecentView({Key? key}) : super(key: key);

  @override
  State<RecentView> createState() => _RecentViewState();
}

class _RecentViewState extends State<RecentView> {
  AppLocalizations? _localizations;

  List<RecentProduct>? _recentProducts;
  late double _size;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _size = (AppSizes.width / 2.5) - AppSizes.linePadding;
    fetchRecentProducts();

    RecentViewController.controller.stream.listen((event) {
      fetchRecentProducts();
    });

    super.initState();
  }

  void fetchRecentProducts() async {
    _recentProducts =
    await (await AppDatabase.getDatabase()).recentProductDao.getProducts();
    _recentProducts = _recentProducts?.reversed.toList();

    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _recentProducts == null || _recentProducts?.isEmpty == true
        ? Container()
        : Container(
      padding:
      const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
      margin: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(vertical: AppSizes.sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _localizations
                  ?.translate(AppStringConstant.recentlyViewed) ??
                  "",
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: AppSizes.extraPadding),
            SizedBox(
              height: ((AppSizes.width / 1.8 )- 2),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {

                  return GestureDetector(
                    onTap: () {
                      AppDatabase.getDatabase().then(
                            (value) => value.recentProductDao
                            .insertRecentProduct(
                          RecentProduct(
                            templateId: _recentProducts?.elementAt(index).templateId.toString() ?? '',
                            name: _recentProducts?.elementAt(index).name,
                            priceUnit: _recentProducts?.elementAt(index).priceUnit,
                            priceReduce: _recentProducts?.elementAt(index).priceReduce,
                            image: _recentProducts?.elementAt(index).image ?? '',
                          ),
                        )
                            .then(
                              (value) =>
                              RecentViewController.controller.sink.add(_recentProducts?.elementAt(index).templateId?.toString() ?? ''),
                        ),
                      );
                      Navigator.of(context).pushNamed(productPage,
                          arguments: getProductDataMap(
                              _recentProducts?.elementAt(index).name ??
                                  '',
                              _recentProducts
                                  ?.elementAt(index)
                                  .templateId
                                  .toString() ??
                                  ''));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: MobikulTheme.lightGrey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(AppSizes.linePadding))
                      ),
                  margin: EdgeInsets.symmetric(horizontal: AppSizes.linePadding/2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(AppSizes.imageRadius),
                            child: ImageView(
                              fit: BoxFit.fill,
                              url:
                              _recentProducts?.elementAt(index).image,
                              width: _size - AppSizes.normalPadding,
                              height: _size - AppSizes.normalPadding,
                            ),
                          ),

                          SizedBox(
                            width: _size,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: AppSizes.imageRadius,
                                  // top: AppSizes.imageRadius,
                                  right: AppSizes.imageRadius),
                              child: Column(
                                children: [
                                  Text(
                                    _recentProducts?.elementAt(index).name ??
                                        "",
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                  ),
                                  Visibility(
                                      visible: (_recentProducts
                                          ?.elementAt(index)
                                          ?.priceReduce ??
                                          '')
                                          .isNotEmpty,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: AppSizes.linePadding,
                                          ),
                                          Text(
                                              _recentProducts
                                                  ?.elementAt(index)
                                                  ?.priceUnit ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2?.copyWith(decoration: TextDecoration.lineThrough)

                                          ),
                                        ],
                                      )),
                                  Text(
                                      (_recentProducts
                                          ?.elementAt(index)
                                          .priceReduce ??
                                          '')
                                          .isNotEmpty
                                          ? _recentProducts
                                          ?.elementAt(index)
                                          ?.priceReduce ??
                                          ''
                                          : _recentProducts
                                          ?.elementAt(index)
                                          ?.priceUnit ??
                                          '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
                itemCount: _recentProducts?.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
