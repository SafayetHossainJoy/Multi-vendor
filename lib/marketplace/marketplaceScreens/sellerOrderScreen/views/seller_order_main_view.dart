
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerOrderModel.dart';
import 'package:flutter_project_structure/screens/orders/views/order_main_view.dart';

Widget sellerOrderMainView(
  BuildContext context,
  List<SellerOrder>? orders,
  AppLocalizations? localizations,
  ScrollController controller,
) {
  return ListView.separated(
    controller: controller,
    shrinkWrap: true,
    itemBuilder: (ctx, index) => orderItem(
      context,
      orders?[index],
      localizations,
    ),
    separatorBuilder: (ctx, index) => const SizedBox(
      height: AppSizes.linePadding,
      child: Divider(),
    ),
    itemCount: (orders?.length ?? 0),
  );
}

Widget orderItem(
    BuildContext context, SellerOrder? item, AppLocalizations? localizations) {
  return Container(
    padding: const EdgeInsets.only(
        top: AppSizes.imageRadius,
        left: AppSizes.imageRadius,
        right: AppSizes.imageRadius),
    margin: const EdgeInsets.only(bottom: AppSizes.imageRadius),
    color: Theme.of(context).cardColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            itemRow(
                context,
                localizations
                        ?.translate(AppStringConstant.order)
                        .replaceAll("#", '') ??
                    '',
                "#${item?.orderReference.toString() ?? " "}"),
            const Spacer(),
            statusContainer(context, item?.orderStatus ?? ''),
          ],
        ),
        const SizedBox(height: AppSizes.imageRadius),
        itemRow(
            context,
            localizations?.translate(AppStringConstant.placedOn) ?? '',
            item?.createDate ?? ''),
        const SizedBox(height: AppSizes.imageRadius),
        itemRow(
            context,
            localizations?.translate(MarketplaceStringConstant.customer) ?? '',
            item?.customer ?? ""),
        const SizedBox(height: AppSizes.imageRadius),
        itemRow(
            context,
            localizations?.translate(AppStringConstant.subtotal) ?? '',
            item?.subTotal ?? "0.00"),
        const SizedBox(height: AppSizes.imageRadius),
      ],
      mainAxisSize: MainAxisSize.min,
    ),
  );
}

Widget itemRow(BuildContext context, String itemLabel, itemValue) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: AppSizes.width / 5,
          child: Text(
            itemLabel,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Text(
          " :  ",
          style: Theme.of(context).textTheme.headline6,
        ),
        Flexible(
            child: Text(
          itemValue,
          style: Theme.of(context).textTheme.headline6,
        ))
      ],
    ),
  );
}
