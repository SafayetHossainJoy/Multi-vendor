import 'dart:convert';
import 'dart:developer';

import 'package:aamarpay/aamarpay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_order_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/OrderReviewModel.dart';
import 'package:flutter_project_structure/models/PaymentModel.dart';
import 'package:flutter_project_structure/models/PlaceOrderModel.dart';
import 'package:flutter_project_structure/screens/addressBook/views/address_item_card.dart';
import 'package:flutter_project_structure/screens/cart/widgets/price_details.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/reviewPayments/widgets/place_order_screen.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/alert_message.dart';
import '../shippingDetails/views/checkout_progress_line.dart';
import '../shippingDetails/views/shipping_methods_view.dart';
import 'bloc/review_screen_bloc.dart';
import 'bloc/review_screen_event.dart';
import 'bloc/review_screen_state.dart';
import 'widgets/order_summary.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:http/http.dart' as http;

class ReviewScreen extends StatefulWidget {
  Map<String, dynamic> args;
  ReviewScreen(this.args, {Key? key}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  AppLocalizations? _localizations;
  bool isAddressSame = false;
  bool isLoading = true;
  PaymentModel? paymentModel;
  OrderReviewModel? orderReviewModel;
  PaymentReviewScreenBloc? paymentReviewScreenBloc;
  PlaceOrderModel? placeOrderModel;
  int selectedPaymentMethodIndex = 0;

  @override
  void initState() {
    paymentReviewScreenBloc = context.read<PaymentReviewScreenBloc>();
    paymentReviewScreenBloc?.add(GetPaymentMethodEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonToolBar(
            _localizations?.translate(AppStringConstant.reviewPayments) ?? "",
            context),
        body: BlocBuilder<PaymentReviewScreenBloc, PaymentReviewScreenState>(
          builder: (context, currentState) {
            if (currentState is PaymentReviewScreenInitial) {
              isLoading = true;
            } else if (currentState is GetPaymentMethodSuccess) {
              isLoading = true;
              paymentModel = currentState.paymentModel;
              paymentReviewScreenBloc?.add(OrderReviewEvent(
                  widget.args[shippingAddressIdKey],
                  paymentModel?.acquirers?[0].id ?? 0,
                  widget.args[shippingIdKey]));
              paymentReviewScreenBloc?.emit(PaymentReviewScreenInitial());
            } else if (currentState is OrderReviewSuccess) {
              isLoading = false;
              if (currentState.orderReviewModel?.success == true) {
                orderReviewModel = currentState.orderReviewModel;
                if ("STRIPE" ==
                    orderReviewModel?.paymentData?.code?.toUpperCase()) {
                  initPaymentSheet();
                } else if ("AAMARPAY" ==
                    orderReviewModel?.paymentData?.code?.toUpperCase()) {
                  //
                  // Handle Aamarpay payment logic
                  // This is where you can show the Aamarpay widget
                  // Handle success and failure callbacks
                  // You can refer to the previous Aamarpay widget implementation
                }
              } else {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AlertMessage.showError(
                      currentState.orderReviewModel?.message ?? '', context);
                });
              }
            } else if (currentState is PlaceOrderSuccess) {
              isLoading = false;
              placeOrderModel = currentState.placeOrderModel;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                if (placeOrderModel?.success ?? false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlaceOrderScreen(placeOrderModel)));
                } else if (placeOrderModel?.cartCount == 0) {
                  AlertMessage.showError(
                      placeOrderModel?.message ?? '', context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, navBar, (route) => false);
                }
              });
            } else if (currentState is PaymentReviewScreenError) {
              isLoading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(currentState.message ?? '', context);
              });
            }
            return _buildUI();
          },
        ));
  }

  Widget _buildUI() {
    return isLoading
        ? Loader()
        : orderReviewModel?.success ?? false
            ? Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          checkoutProgressLine(false, context),
                          showBillingAddress(
                              context, AppStringConstant.billingAddress),
                          shippinginfo(AppStringConstant.shippingInfo),
                          shippingMethod(),
                          paymentMethod(), // This is where the Aamarpay widget is integrated
                          orderSummary(context, _localizations,
                              orderReviewModel?.items ?? []),
                          PriceDetails(
                            grandTotal:
                                orderReviewModel?.grandtotal?.value ?? "",
                            localizations: _localizations,
                            totalTax: orderReviewModel?.tax?.value,
                            totalProducts: orderReviewModel?.subtotal?.value,
                          )
                        ],
                      ),
                    ),
                  ),
                  if (selectedPaymentMethodIndex == 2) ...[
                    Container(
                      // height: 55,
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.all(AppSizes.imageRadius),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  _localizations?.translate(
                                          AppStringConstant.amountToBePaid) ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(fontSize: 13),
                                ),
                                Text(
                                      "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(fontWeight: FontWeight.bold)
                                    //?.copyWith(fontSize: TextSizes.mediumTextSize),
                                    )
                              ],
                            ),
                          ),
                          Aamarpay(
                            returnUrl: (String url) {
                              // Handle the payment success or failure URL
                              print("Aamarpay returnUrl: $url");
                            },
                            isLoading: (bool loading) {
                              // Handle loading state
                              setState(() {
                                isLoading = loading;
                              });
                            },
                            status: (EventState event, String message) {
                              // Handle payment status
                              print("Aamarpay status: $event - $message");
                              if (event == EventState.success) {
                                // Payment was successful
                                // You can proceed with placing the order
                                paymentReviewScreenBloc?.add(PlaceOrderEvent(
                                    "",
                                    orderReviewModel?.transactionId ?? 0,
                                    "",
                                    "",
                                    orderReviewModel
                                            ?.paymentData?.customerEmail ??
                                        ""));
                                paymentReviewScreenBloc
                                    ?.emit(PaymentReviewScreenInitial());
                              }
                            },
                            // Fill in the required Aamarpay configuration details
                            cancelUrl:
                                "https://www.islamicitem.com/payment/aamarpay/cancel",
                            successUrl:
                                "https://www.islamicitem.com/payment/aamarpay/success",
                            failUrl:
                                "https://www.islamicitem.com/payment/aamarpay/fail",
                            customerEmail: "shj.app117@gmail.com",
                            customerMobile: "01975718035",
                            customerName: "Safayet Hossain",
                            signature: "dbb74894e82415a2f7ff0ec3a97e4183",
                            storeID: "aamarpaytest",
                            transactionAmount: "200",
                            transactionID:
                                "${DateTime.now().millisecondsSinceEpoch}",
                            description: "Order Payment",
                            isSandBox: true,
                            child: isLoading!
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(
                                    color: Colors.green,
                                    height: 50,
                                    width: 150,
                                    child: const Center(
                                      child: Text(
                                        "Place Order",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    commonOrderButton(context, _localizations,
                        orderReviewModel?.grandtotal?.value ?? "", () {
                      if ("STRIPE" ==
                          orderReviewModel?.paymentData?.code?.toUpperCase()) {
                        _displayPaymentSheet();
                      } else {
                        paymentReviewScreenBloc?.add(PlaceOrderEvent("",
                            orderReviewModel?.transactionId ?? 0, "", "", ""));
                        paymentReviewScreenBloc
                            ?.emit(PaymentReviewScreenInitial());
                      }
                    },
                        color: AppColors.success,
                        title: AppStringConstant.placeOrder)
                  ],
                ],
              )
            : Container();
  }

  // Widget _buildUI() {
  //   return isLoading
  //       ? Loader()
  //       : orderReviewModel?.success ?? false
  //           ? Column(
  //               children: [
  //                 Expanded(
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         checkoutProgressLine(false, context),
  //                         showBillingAddress(
  //                             context, AppStringConstant.billingAddress),
  //                         shippinginfo(AppStringConstant.shippingInfo),
  //                         shippingMethod(),
  //                         paymentMethod(),
  //                         orderSummary(context, _localizations,
  //                             orderReviewModel?.items ?? []),
  //                         PriceDetails(
  //                           grandTotal:
  //                               orderReviewModel?.grandtotal?.value ?? "",
  //                           localizations: _localizations,
  //                           totalTax: orderReviewModel?.tax?.value,
  //                           totalProducts: orderReviewModel?.subtotal?.value,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 commonOrderButton(context, _localizations,
  //                     orderReviewModel?.grandtotal?.value ?? "", () {
  //                   if ("STRIPE" ==
  //                       orderReviewModel?.paymentData?.code?.toUpperCase()) {
  //                     _displayPaymentSheet();
  //                   }
  //                   else {
  //                     paymentReviewScreenBloc?.add(PlaceOrderEvent(
  //                         "", orderReviewModel?.transactionId ?? 0, "", "",""));
  //                     paymentReviewScreenBloc
  //                         ?.emit(PaymentReviewScreenInitial());
  //                   }
  //                 },
  //                     color: AppColors.success,
  //                     title: AppStringConstant.placeOrder)
  //               ],
  //             )
  //           : Container();
  // }

  Widget showBillingAddress(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.imageRadius),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.imageRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.linePadding,
                  horizontal: AppSizes.imageRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _localizations?.translate(title) ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: AppColors.lightGray),
                  ),

                  /// Amar pay kothai implement k
                  SizedBox(
                    height: 30,
                    width: 60,
                    child: OutlinedButton(
                      child: Text(
                        (_localizations?.translate(AppStringConstant.edit) ??
                                "EDIT")
                            .toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontSize: 12, color: AppColors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.black,
                          shape: const StadiumBorder(),
                          padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.pushNamed(context, addEditAddress,
                                arguments: widget.args[addressEndpointKey])
                            .then((value) {
                          if (value == true) {
                            paymentReviewScreenBloc
                                ?.add(GetPaymentMethodEvent());
                            paymentReviewScreenBloc
                                ?.emit(PaymentReviewScreenInitial());
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            addressItemCard(
              orderReviewModel?.billingAddress ?? "",
              context,
            )
          ],
        ),
      ),
    );
  }

  Widget shippinginfo(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.mediumPadding),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.imageRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.imageRadius),
              child: Text(
                _localizations?.translate(title) ?? "",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: AppColors.lightGray),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: AppSizes.imageRadius,
                  left: AppSizes.imageRadius,
                  right: AppSizes.imageRadius),
              child: Text(
                _localizations
                        ?.translate(AppStringConstant.shippingAddress)
                        .toUpperCase() ??
                    "",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: AppColors.lightGray),
              ),
            ),
            addressItemCard(orderReviewModel?.shippingAddress ?? '', context),
            // Padding(
            //   padding: const EdgeInsets.only(top: AppSizes.imageRadius, left: AppSizes.imageRadius,right: AppSizes.imageRadius),
            //   child: Text(_localizations?.translate(AppStringConstant.shippingMethod).toUpperCase() ?? "", style: Theme
            //       .of(context)
            //       .textTheme
            //       .headline6
            //       ?.copyWith(color: AppColors.lightGray),),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: AppSizes.linePadding,horizontal: AppSizes.imageRadius),
            //   child: Text(orderReviewModel?.delivery?.name ?? '', style: Theme
            //       .of(context)
            //       .textTheme
            //       .bodyLarge
            //       ?.copyWith(fontWeight: FontWeight.normal),),
            // ),
          ],
        ),
      ),
    );
  }

  Widget shippingMethod() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.mediumPadding),
      child: Container(
        width: AppSizes.width,
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.imageRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.imageRadius),
              child: Text(
                _localizations
                        ?.translate(AppStringConstant.shippingMethod)
                        .toUpperCase() ??
                    "",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: AppColors.lightGray),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(
                AppSizes.imageRadius,
              ),
              child: Text(
                orderReviewModel?.delivery?.name ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
  /*
  Widget paymentMethod() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.mediumPadding),
    child: Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(top: AppSizes.imageRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.imageRadius),
            child: Text(
              _localizations?.translate(AppStringConstant.paymentMethods) ?? "",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: AppColors.lightGray),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ShippingMethodsView(
            paymentMethods: paymentModel?.acquirers,
            callBack: (index) {
              selectedPaymentMethodIndex = index;
            },
            paymentcallback: (index) {
              debugPrint("payment --->" + index.toString());
              selectedPaymentMethodIndex = index;
              paymentReviewScreenBloc?.add(OrderReviewEvent(
                  widget.args[shippingAddressIdKey],
                  paymentModel?.acquirers?[selectedPaymentMethodIndex].id ?? 0,
                  widget.args[shippingIdKey]));
              paymentReviewScreenBloc?.emit(PaymentReviewScreenInitial());
            },
            selectedPaymentIndex: selectedPaymentMethodIndex,
          ),
          // Integrate Aamarpay Payment Gateway if selectedPaymentMethodIndex is 2
          if (selectedPaymentMethodIndex == 2)
            Aamarpay(
              returnUrl: (String url) {
                // Handle the payment success or failure URL
                print("Aamarpay returnUrl: $url");
              },
              isLoading: (bool loading) {
                // Handle loading state
                setState(() {
                  isLoading = loading;
                });
              },
              status: (EventState event, String message) {
                // Handle payment status
                print("Aamarpay status: $event - $message");
                if (event == EventState.success) {
                  // Payment was successful
                  // You can proceed with placing the order
                  paymentReviewScreenBloc?.add(PlaceOrderEvent(
                      "",
                      orderReviewModel?.transactionId ?? 0,
                      "",
                      "",
                      orderReviewModel?.paymentData?.customerEmail ?? ""));
                  paymentReviewScreenBloc?.emit(PaymentReviewScreenInitial());
                }
              },
              cancelUrl:
                    "https://www.islamicitem.com/payment/aamarpay/cancel",
                successUrl:
                    "https://www.islamicitem.com/payment/aamarpay/success",
                failUrl: "https://www.islamicitem.com/payment/aamarpay/fail",
                customerEmail: "shj.app117@gmail.com",
                customerMobile: "01975718035",
                customerName: "Safayet Hossain",
                signature: "dbb74894e82415a2f7ff0ec3a97e4183",
                storeID: "aamarpaytest",
                transactionAmount: "200",
                transactionID: "${DateTime.now().millisecondsSinceEpoch}",
                description: "Order Payment",
                isSandBox: true, child: selectedPaymentMethodIndex == 2 // Assuming 2 is the index for AAMARPAY
      ? isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ):  commonOrderButton(context, _localizations,
                      orderReviewModel?.grandtotal?.value ?? "", () {
                    // if ("STRIPE" ==
                    //     orderReviewModel?.paymentData?.code?.toUpperCase()) {
                    //   _displayPaymentSheet();
                    // } else {
                    //   paymentReviewScreenBloc?.add(PlaceOrderEvent("",
                    //       orderReviewModel?.transactionId ?? 0, "", "", ""));
                    //   paymentReviewScreenBloc
                    //       ?.emit(PaymentReviewScreenInitial());
                    // }
                  },
                      color: AppColors.success,
                      title: AppStringConstant.placeOrder):Container(),
            ),
        ],
      ),
    ),
  );
}
  */

  Widget paymentMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.mediumPadding),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.imageRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.imageRadius),
              child: Text(
                _localizations?.translate(AppStringConstant.paymentMethods) ??
                    "",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: AppColors.lightGray),
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ShippingMethodsView(
              paymentMethods: paymentModel?.acquirers,
              callBack: (index) {
                selectedPaymentMethodIndex = index;
              },
              paymentcallback: (index) {
                debugPrint("payment --->" + index.toString());
                selectedPaymentMethodIndex = index;
                paymentReviewScreenBloc?.add(OrderReviewEvent(
                    widget.args[shippingAddressIdKey],
                    paymentModel?.acquirers?[selectedPaymentMethodIndex].id ??
                        0,
                    widget.args[shippingIdKey]));
                paymentReviewScreenBloc?.emit(PaymentReviewScreenInitial());
              },
              selectedPaymentIndex: selectedPaymentMethodIndex,
            ),
            // Integrate Aamarpay Payment Gateway
            // if (selectedPaymentMethodIndex == 2)
            //   Aamarpay(
            //     returnUrl: (String url) {
            //       // Handle the payment success or failure URL
            //       print("Aamarpay returnUrl: $url");
            //     },
            //     isLoading: (bool loading) {
            //       // Handle loading state
            //       setState(() {
            //         isLoading = loading;
            //       });
            //     },
            //     status: (EventState event, String message) {
            //       // Handle payment status
            //       print("Aamarpay status: $event - $message");
            //       if (event == EventState.success) {
            //         // Payment was successful
            //         // You can proceed with placing the order
            //         paymentReviewScreenBloc?.add(PlaceOrderEvent(
            //             "",
            //             orderReviewModel?.transactionId ?? 0,
            //             "",
            //             "",
            //             orderReviewModel?.paymentData?.customerEmail ?? ""));
            //         paymentReviewScreenBloc?.emit(PaymentReviewScreenInitial());
            //       }
            //     },
            //     // Fill in the required Aamarpay configuration details
            //     cancelUrl:
            //         "https://www.islamicitem.com/payment/aamarpay/cancel",
            //     successUrl:
            //         "https://www.islamicitem.com/payment/aamarpay/success",
            //     failUrl: "https://www.islamicitem.com/payment/aamarpay/fail",
            //     customerEmail: "shj.app117@gmail.com",
            //     customerMobile: "01975718035",
            //     customerName: "Safayet Hossain",
            //     signature: "dbb74894e82415a2f7ff0ec3a97e4183",
            //     storeID: "aamarpaytest",
            //     transactionAmount: "200",
            //     transactionID: "${DateTime.now().millisecondsSinceEpoch}",
            //     description: "Order Payment",
            //     isSandBox: true,
            //     child: isLoading
            //         ? const Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         : Container(
            //             color: Colors.orange,
            //             height: 50,
            //             child: const Center(
            //               child: Text(
            //                 "Pay with Aamarpay",
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.white,
            //                 ),
            //               ),
            //             ),
            //           ),
            //   ),
          ],
        ),
      ),
    );
  }

  // Widget paymentMethod() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: AppSizes.mediumPadding),
  //     child: Container(
  //       color: Theme.of(context).cardColor,
  //       margin: const EdgeInsets.only(top: AppSizes.imageRadius),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(AppSizes.imageRadius),
  //             child: Text(
  //               _localizations?.translate(AppStringConstant.paymentMethods) ??
  //                   "",
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .headline6
  //                   ?.copyWith(color: AppColors.lightGray),
  //             ),
  //           ),
  //           const Divider(
  //             height: 1,
  //             thickness: 1,
  //           ),
  //           ShippingMethodsView(
  //             paymentMethods: paymentModel?.acquirers,
  //             callBack: (index) {
  //               selectedPaymentMethodIndex = index;
  //             },
  //             paymentcallback: (index) {
  //               debugPrint("payment --->" + index.toString());
  //               selectedPaymentMethodIndex = index;
  //               paymentReviewScreenBloc?.add(OrderReviewEvent(
  //                   widget.args[shippingAddressIdKey],
  //                   paymentModel?.acquirers?[selectedPaymentMethodIndex].id ??
  //                       0,
  //                   widget.args[shippingIdKey]));
  //               paymentReviewScreenBloc?.emit(PaymentReviewScreenInitial());
  //             },
  //             selectedPaymentIndex: selectedPaymentMethodIndex,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void billingAddress(bool isOn) {
    setState(() {
      isAddressSame = isOn;
      isAddressSame = !isAddressSame;
    });
  }

  Future<void> initPaymentSheet() async {
    if ("STRIPE" == orderReviewModel?.paymentData?.code?.toUpperCase()) {
      try {
        stripe.Stripe.publishableKey =
            orderReviewModel?.paymentData?.publishableKey ?? "";

        await stripe.Stripe.instance.applySettings();

        await stripe.Stripe.instance.initPaymentSheet(
          paymentSheetParameters: stripe.SetupPaymentSheetParameters(
            customFlow: true,
            merchantDisplayName:
                _localizations?.translate(AppStringConstant.APPNAME),
            paymentIntentClientSecret:
                orderReviewModel?.paymentData?.piToken ?? "",
            customerEphemeralKeySecret: "",
            customerId: "",
            setupIntentClientSecret: "",
            // returnURL: orderReviewModel?.paymentData?.callBackUrl??"",
            style: ThemeMode.light,
          ),
        );
      } catch (e, stack) {
        debugPrintStack(label: e.toString(), stackTrace: stack);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        rethrow;
      }
    }
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance
          .presentPaymentSheet(
        options: const stripe.PaymentSheetPresentOptions(timeout: 1200000),
      )
          .then((value) async {
        debugPrint("value -->" + value.toString());

        stripe.Stripe.instance.confirmPaymentSheetPayment().then((value) {
          paymentReviewScreenBloc?.add(PlaceOrderEvent(
              "",
              orderReviewModel?.transactionId ?? 0,
              "",
              "",
              orderReviewModel?.paymentData?.stripeCustomerId ?? ""));
          paymentReviewScreenBloc?.emit(PaymentReviewScreenInitial());
        });
      });
    } catch (e, stack) {
      debugPrintStack(label: e.toString(), stackTrace: stack);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }
}
