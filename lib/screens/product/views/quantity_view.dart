
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../bloc/product_screen_bloc.dart';
import '../bloc/product_screen_event.dart';
import '../bloc/product_screen_state.dart';

class QuantityView extends StatefulWidget {
  ValueChanged<int>? callBack;
  ProductScreenBloc? bloc;
  int? counter;

  QuantityView({this.callBack, this.bloc, this.counter});

  @override
  State<StatefulWidget> createState() {
    return _QuantityViewState();
  }
}

class _QuantityViewState extends State<QuantityView> {
  TextEditingController controller = TextEditingController();
  ProductScreenBloc? bloc;
  AppLocalizations? _localizations;

  @override
  void initState() {
    controller.text =
    "${widget.counter} ${_localizations?.translate(AppStringConstant.unit) ??
        'Unit'}";
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(AppSizes.normalPadding),
      color: Theme
          .of(context)
          .cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _localizations?.translate(AppStringConstant.quantity) ?? '',
            style: Theme
                .of(context)
                .textTheme
                .subtitle2,
          ),
          SizedBox(
            height: AppSizes.normalPadding,
          ),
          Divider(),
          SizedBox(
            height: AppSizes.normalPadding,
          ),
          SizedBox(
            height: AppSizes.width / 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Container(
                //   width: AppSizes.width / 6,
                //   color: AppColors.black,
                //   child: InkWell(
                //       onTap: () {
                //         if (widget.counter! > 1) {
                //           // setState(() {
                //           widget.counter = (widget.counter ?? 1) - 1;
                //           changeQty();
                //           // });
                //         }
                //       },
                //       child: Icon(Icons.remove,
                //           size: 30, color: AppColors.white)),
                // ),
                commonButton(context, () {
                  if (widget.counter! > 1) {
                    // setState(() {
                    widget.counter = (widget.counter ?? 1) - 1;
                    changeQty();
                    // });
                  }
                }, '', widget:Icon(Icons.remove,
                    size: 30, color: AppColors.white),
                    width: AppSizes.width / 6,
                    backgroundColor: AppColors.black,
                    textColor:
                    Theme.of(context).colorScheme.secondaryContainer
                ),
                Spacer(),
                SizedBox(
                    width: AppSizes.width / 6,
                    child: TextField(
                      enabled: false,
                      controller: controller,
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
                Spacer(),
                // Container(
                //   width: AppSizes.width / 6,
                //   color: Colors.black,
                //   child: InkWell(
                //       onTap: () {
                //         // setState(() {
                //         widget.counter = (widget.counter ?? 1) + 1;
                //         changeQty();
                //         // });
                //       },
                //       child: Icon(
                //         Icons.add,
                //         size: 30,
                //         color: AppColors.white,
                //       )),
                // ),
                commonButton(context, () {
                  widget.counter = (widget.counter ?? 1) + 1;
                  changeQty();
                }, '', widget: Icon(
                  Icons.add,
                  size: 30,
                  color: AppColors.white,
                ),
                    width: AppSizes.width / 6,
                    backgroundColor: AppColors.black,
                    textColor:
                    Theme.of(context).colorScheme.secondaryContainer
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void changeQty() {
    print("qadsqds--${widget.counter}");
    widget.bloc?.add(QuantityUpdateEvent(widget.counter));
    widget.bloc?.emit(ProductScreenInitial());
    controller.text = ("${widget.counter}" +
        ((widget.counter! > 1)
            ? " ${_localizations?.translate(AppStringConstant.units)}"
            : " ${_localizations?.translate(AppStringConstant.unit)}"));
  }
}
