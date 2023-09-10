
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';

import '../../../constants/app_constants.dart';

Widget addressItemWithHeading(
    BuildContext context, String title, String address,
    {Widget? addressList,
    Widget? actions,
    bool? showDivider,
    bool? isElevated,
    VoidCallback? callback}) {
  return Container(
    color: Theme.of(context).cardColor,
    margin: const EdgeInsets.only(top: AppSizes.imageRadius),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.imageRadius),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        if (showDivider ?? false)
          const Divider(
            thickness: 1,
            height: 1,
          ),
        addressList ??
            addressItemCard(address, context,
                actions: actions, isElevated: isElevated, callback: callback)
      ],
    ),
  );
}

Widget addressItemCard(String address, BuildContext context,
    {Widget? actions,
    bool? isElevated,
    VoidCallback? callback,
    bool? isSelected}) {
  return Container(
    // elevation: (isElevated ?? true) ? AppSizes.linePadding : 0,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
    ),
    // margin: const EdgeInsets.fromLTRB(0, AppSizes.imageRadius, 0, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.imageRadius),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (callback != null) ? callback : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text:address.substring(0, address.indexOf("\n")),
                            style: TextStyle(fontWeight:FontWeight.w400, color: Theme.of(context).appBarTheme.titleTextStyle?.color,fontSize: 15,)
                          ),
                          TextSpan(
                            text: address.substring(address.indexOf("\n")).replaceAll("\n\n", "\n"),
                            style: const TextStyle(
                                      color: AppColors.lightGray,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)
                          )
                        ]
                      ),
                    )

                  //   Text(
                  // address.replaceFirst("\n\n", "\n"),
                  // style: (isSelected ?? false)
                  //     ? const TextStyle(fontWeight: FontWeight.bold)
                  //     : const TextStyle(
                  //         color: AppColors.lightGray,
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w400),
                // )
          ),

                if (callback != null)
                  const Icon(
                    Icons.navigate_next,
                    color: AppColors.lightGray,
                  )
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          height: 1,
        ),
        if (actions != null) actions,
      ],
    ),
  );
}

Widget actionContainer(
    BuildContext context, VoidCallback leftCallback, VoidCallback rightCallback,
    {IconData? iconLeft,
    IconData? iconRight,
    String? titleLeft,
    String? titleRight,
    bool? isForDefaultAddress}) {
  return IntrinsicHeight(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
      child: (isForDefaultAddress ?? false)
          ? Container(
              margin: const EdgeInsets.only(bottom: AppSizes.normalPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: leftCallback,
                    child: Row(
                      children: [
                        Icon(
                          iconLeft ?? Icons.edit,
                          size: AppSizes.widgetSidePadding,
                        ),
                        const SizedBox(
                          width: AppSizes.linePadding,
                        ),
                        Text((titleLeft ?? ''),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: leftCallback,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        iconLeft ?? Icons.edit_outlined,
                        size: AppSizes.widgetSidePadding,
                      ),
                      const SizedBox(
                        width: AppSizes.linePadding,
                      ),
                      Text((titleLeft ?? '').toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                const VerticalDivider(
                  thickness: 2,
                  width: 0,
                ),
                if ((iconRight != Icons.rate_review_outlined) ||
                    ((iconRight == Icons.rate_review_outlined) &&
                        (AppSharedPref().getSplashData()?.addons?.review ??
                            false)))
                  InkWell(
                    onTap: rightCallback,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          iconRight ?? Icons.add,
                          size: AppSizes.widgetSidePadding,
                        ),
                        const SizedBox(
                          width: AppSizes.linePadding,
                        ),
                        Text(
                            // _localizations?.translate(AppStringConstant.newAddress) ??
                            (titleRight ?? "").toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
              ],
            ),
    ),
  );
}
