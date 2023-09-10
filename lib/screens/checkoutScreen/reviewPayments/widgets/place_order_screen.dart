
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/PlaceOrderModel.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/app_string_constant.dart';
import '../../../../constants/arguments_map.dart';
import '../../../../constants/route_constant.dart';

class PlaceOrderScreen extends StatefulWidget {
  PlaceOrderModel? placeOrderModel;
  PlaceOrderScreen(this.placeOrderModel, {Key? key}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  bool isLoading = true;
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Center(
            child: Container(
              // height: AppSizes.height / 3,
              width: AppSizes.width - 50,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(width: 1.0, color: AppColors.background),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.placeOrderModel?.message ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.imageRadius),
                    child: Text(
                      _localizations?.translate(
                              AppStringConstant.thanksForPurchase) ??
                          "",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(fontWeight: FontWeight.normal),
                    ),
                  ),
                  Visibility(
                    visible: (widget.placeOrderModel?.txnMsg ?? "").isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.imageRadius),
                      child:


                      Text(
                        widget.placeOrderModel?.txnMsg ?? "",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.imageRadius),
                        child: Text(
                          _localizations
                                  ?.translate(AppStringConstant.yourOrderIs) ??
                              "",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, orderDetails,
                                arguments: getOrderDetailDataMap(
                                    widget.placeOrderModel?.url ?? '',
                                    fromOrderList: false));
                          },
                          child: Text(
                            widget.placeOrderModel?.name ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.imageRadius),
                      child: commonButton(context, () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, navBar, (route) => false);
                      },
                          _localizations?.translate(
                                  AppStringConstant.continueShopping) ??
                              "",
                          backgroundColor: AppColors.black,
                          width: AppSizes.width / 1.5,
                          textColor: AppColors.white))
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, navBar, (route) => false);
          return true;
        });
  }
}
