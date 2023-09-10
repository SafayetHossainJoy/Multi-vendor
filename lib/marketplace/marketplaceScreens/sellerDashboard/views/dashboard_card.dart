
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';

Widget cardView(BuildContext context, String title, {required String topLabel, required String centerLabel,required String bottomLabel,required String topValue,required String centerValue,required String bottomValue,  VoidCallback? topCallback,VoidCallback? centerCallback,VoidCallback? bottomCallback, }){
  return Card(
    elevation: 6,
    margin: const EdgeInsets.all(AppSizes.genericPadding),
    color: Theme.of(context).cardColor,
    shape: RoundedRectangleBorder(
      side:  BorderSide(color: Theme.of(context).cardColor, width: 1),
      borderRadius: BorderRadius.circular(10),),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: AppSizes.app_bar_size,
          width: AppSizes.width,
          decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:  Radius.circular(10))
          ),
          child: Center(
            child: Text(title,style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.white), ),
          ),
        ),
        listItem(context,topLabel , topValue, topCallback ),
        const Divider(
          height: AppSizes.linePadding,
        ),
        listItem(context, centerLabel , centerValue,  centerCallback ),
        const Divider(
          height: AppSizes.linePadding,
        ),
        listItem(context,bottomLabel , bottomValue, bottomCallback )

      ],
    ),
  );
}

Widget listItem(BuildContext context, String label, String value, VoidCallback? callback ){
  return
    GestureDetector(
    onTap: (callback != null) ? callback : null,
    child: ListTile(
        dense: true,
      leading: Text(label, style: Theme.of(context).textTheme.labelLarge,),
      trailing: (callback != null) ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: Theme.of(context).textTheme.labelLarge,),
          const Icon(Icons.navigate_next)
        ],
      ) : null,
  ),
    );
}