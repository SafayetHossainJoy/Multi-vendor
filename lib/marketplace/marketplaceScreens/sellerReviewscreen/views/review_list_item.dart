
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/MarketPlaceModel.dart';
import 'package:flutter_project_structure/screens/product/views/rating_container.dart';


Widget reviewListItemCard(SellerReviews? reviewData, BuildContext context,
    GestureTapCallback onLike, GestureTapCallback onDislike) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RatingContainer(double.parse((reviewData?.rating ?? 0).toString())),
          const SizedBox(
            width: AppSizes.normalPadding / 2,
          ),
          Text(
            '${reviewData?.title}',
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
      const SizedBox(
        height: AppSizes.normalPadding,
      ),
      Flexible(child: Text("${reviewData?.msg}")),
      const SizedBox(
        height: AppSizes.normalPadding,
      ),
      Text(
        '${reviewData?.name}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.headline3?.color),
      ),
      const SizedBox(
        height: AppSizes.normalPadding,
      ),
      Text(
        '(${reviewData?.createDate})',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      const SizedBox(
        height: AppSizes.normalPadding,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onLike,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.thumb_up),
                const SizedBox(
                  width: AppSizes.normalPadding / 2,
                ),
                Text("${reviewData?.helpful ?? 0}",
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          ),
          InkWell(
            onTap: onDislike,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.thumb_down),
                const SizedBox(
                  width: AppSizes.normalPadding / 2,
                ),
                Text("${reviewData?.notHelpful ?? 0}",
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          )
        ],
      ),
    ],
  );
}
