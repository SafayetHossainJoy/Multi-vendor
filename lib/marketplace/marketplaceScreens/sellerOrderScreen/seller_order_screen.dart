
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/customWidgtes/lottie_animation.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerOrderModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerOrderScreen/bloc/seller_order_screen_state.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerOrderScreen/bloc/seller_order_screen_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerOrderScreen/bloc/seller_order_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerOrderScreen/views/seller_order_main_view.dart';
import 'package:lottie/lottie.dart';

class SellerOrderScreen extends StatefulWidget {
  String state;
   SellerOrderScreen({Key? key, this.state = '',}) : super(key: key);

  @override
  State<SellerOrderScreen> createState() => _SellerOrderScreenState();
}

class _SellerOrderScreenState extends State<SellerOrderScreen> {
  final ScrollController _scrollController = ScrollController();
  AppLocalizations? _localizations;
  SellerOrderScreenBloc? _orderScreenBloc;
  bool isLoading = false;
  bool isFromPagination = false;
  SellerOrderModel? orderList;
  List<SellerOrder> sellerOrders = [];
  int offset = 0;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _orderScreenBloc = context.read<SellerOrderScreenBloc>();
    _orderScreenBloc
        ?.add( SellerOrderScreenDataFetchEvent(0, 10, widget.state));
    _scrollController.addListener(() {
     paginationFunction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonToolBar(
          _localizations?.translate(MarketplaceStringConstant.sellerOrder) ?? '',
          context),
      body: BlocBuilder<SellerOrderScreenBloc, SellerOrderScreenState>(
          builder: (context, currentState) {
            if (currentState is SellerOrderScreenInitialState) {
              if (!isFromPagination) {
                isLoading = true;
              }
            } else if (currentState is SellerOrderScreenSuccess) {
              isLoading = false;
              isFromPagination = false;
              orderList = currentState.orders;
              if (offset == 0) {
                sellerOrders = orderList?.sellerOrder ?? [];
              } else {
                sellerOrders.addAll(orderList?.sellerOrder ?? []);
              }
            } else if (currentState is SellerOrderScreenError) {
              isLoading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(currentState.message, context);
              });
            }
            return _buildUI();
          }),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        if (sellerOrders.isNotEmpty)
          sellerOrderMainView(context, sellerOrders, _localizations,  _scrollController,
          ),
        Visibility(
          visible: (sellerOrders.isEmpty && (!isLoading)),
          child: Center(
            child: lottieAnimation(context,
                (Theme.of(context).brightness == Brightness.light) ? "lib/assets/lottie/empty_order_list.json" : "lib/assets/lottie/empty_order_list_dark.json",
                _localizations?.translate(AppStringConstant.noOrderFount) ?? '',
                '',
                '',
                    () { }
            )

            // Lottie.asset("lib/assets/lottie/empty_order_list.json",
            //     width: AppSizes.width / 2,
            //     height: AppSizes.height / 3.5,
            //     fit: BoxFit.fill,
            //     repeat: false
            // ),
          ),
        ),
        Visibility(visible: isLoading, child: Loader())
      ],
    );
  }

  void paginationFunction() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent &&
        (orderList?.totalCount ?? 0) != sellerOrders.length) {
      setState(() {
        if ((offset + 10) < (orderList?.totalCount ?? 0)) {
          offset += 10;

            _orderScreenBloc?.add(SellerOrderScreenDataFetchEvent(offset, 10, widget.state));

          isFromPagination = true;
        }
      });
    }
  }
}
