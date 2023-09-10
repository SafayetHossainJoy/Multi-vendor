
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';

Widget commonButton(BuildContext context, VoidCallback onPressed, String text,
    {double? width,
    double? height,
      Widget? widget,
    Color? textColor,
    Color? backgroundColor,
    Color? borderSideColor,
      double borderRadius = 4
    }) {

  return OutlinedButton(
    onPressed: onPressed,
    child:widget ?? Text(
      text,
      style: Theme.of(context).textTheme.headline6?.copyWith(color: textColor),
    ),
    style: OutlinedButton.styleFrom(
        side: borderSideColor != null ? BorderSide(color: borderSideColor) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        minimumSize: Size((width != null) ? width : AppSizes.width,
            (height != null) ? height : AppSizes.height / 16),
        backgroundColor: backgroundColor),
  );
}
