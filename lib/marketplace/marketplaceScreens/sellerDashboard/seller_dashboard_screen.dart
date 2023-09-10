
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_route_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstant/marketplace_arguments_map.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerDashboardModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerDashboard/bloc/seller_dashboard_screen_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerDashboard/bloc/seller_dashboard_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerDashboard/bloc/seller_dashboard_screen_state.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerDashboard/views/dashboard_card.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({Key? key}) : super(key: key);

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  SellerDashboardScreenBloc? _sellerDashboardScreenBloc;
  SellerDashboardModel? dashboardData;
  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }
  @override
  void initState() {
    _sellerDashboardScreenBloc = context.read<SellerDashboardScreenBloc>();
    _sellerDashboardScreenBloc?.add(const SellerDashboardScreenDataFetchEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: commonAppBar(_localizations?.translate(MarketplaceStringConstant.sellerDashboard) ?? '', context),
      body: BlocBuilder<SellerDashboardScreenBloc, SellerDashboardScreenState>(
        builder: (context, state) {
          if(state is SellerDashboardInitialState){
            isLoading = true;
          }
          else if(state is SellerDashboardScreenSuccessState){
            isLoading = false;
            dashboardData = state.data;
          }
          else if( state is SellerDashboardScreenErrorState){
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(state.message, context);
            });
          }
          return Stack(
            children:[
              buildUi(),
              Visibility(
                visible: isLoading,
                  child: Loader()
              )
            ]
          );
        }),
    );
  }

  Widget buildUi(){
    return Visibility(
      visible: (dashboardData?.sellerDashboard  != null),
        child: SingleChildScrollView(
          child: Column(
            children: [
              cardView(
                context,
                _localizations?.translate(MarketplaceStringConstant.orders) ?? '',
                bottomLabel: _localizations?.translate(MarketplaceStringConstant.shipped) ?? '',
                bottomValue: (dashboardData?.sellerDashboard?.shippedOrderCount ?? '').toString(),
                centerLabel: _localizations?.translate(MarketplaceStringConstant.approved) ?? '',
                centerValue: (dashboardData?.sellerDashboard?.approvedOrderCount ?? '').toString(),
                topLabel:_localizations?.translate(MarketplaceStringConstant.newOrder) ?? '',
                topValue:(dashboardData?.sellerDashboard?.newOrderCount ?? '').toString(),
                topCallback: (){
                  Navigator.pushNamed(context, sellerOrder, arguments: 'new');
                },
                centerCallback: (){
                  Navigator.pushNamed(context, sellerOrder, arguments: 'approved');
                },
                bottomCallback: (){
                  Navigator.pushNamed(context, sellerOrder, arguments: 'shipped');
                }
              ),
              cardView(
                  context,
                  _localizations?.translate(AppStringConstant.products) ?? '',
                  bottomLabel: _localizations?.translate(MarketplaceStringConstant.rejected) ?? '',
                  bottomValue: (dashboardData?.sellerDashboard?.rejectedProductCount ?? '').toString(),
                  centerLabel: _localizations?.translate(MarketplaceStringConstant.approved) ?? '',
                  centerValue: (dashboardData?.sellerDashboard?.approvedProductCount ?? '').toString(),
                  topLabel:_localizations?.translate(MarketplaceStringConstant.pending) ?? '',
                  topValue:(dashboardData?.sellerDashboard?.pendingProductCount ?? '').toString(),
                  topCallback: (){
                    Navigator.pushNamed(context, sellerProduct, arguments: sellerProductDataMap('pending', '='));
                  },
                  centerCallback: (){
                    Navigator.pushNamed(context, sellerProduct, arguments: sellerProductDataMap('approved', '='));
                  },
                  bottomCallback: (){
                    Navigator.pushNamed(context, sellerProduct, arguments: sellerProductDataMap('rejected', '='));
                  }
              ),
              cardView(
                  context,
                  _localizations?.translate(MarketplaceStringConstant.payments) ?? '',
                  bottomLabel: _localizations?.translate(MarketplaceStringConstant.rejected) ?? '',
                  bottomValue:  '',
                  centerLabel: _localizations?.translate(MarketplaceStringConstant.approved) ?? '',
                  centerValue: '',
                  topLabel:_localizations?.translate(MarketplaceStringConstant.requested) ?? '',
                  topValue:''
              ),
            ],
          ),
        )
    );
  }
}

