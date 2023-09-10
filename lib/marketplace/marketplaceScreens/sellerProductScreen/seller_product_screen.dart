
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstant/marketplace_arguments_map.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerProductModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProductScreen/bloc/seller_Product_screen_state.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProductScreen/bloc/seller_product_screen_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProductScreen/bloc/seller_product_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProductScreen/views/seller_product_list_item.dart';

class SellerProductScreen extends StatefulWidget {
  Map<String, String> arg;

  SellerProductScreen(this.arg, {Key? key}) : super(key: key);

  @override
  State<SellerProductScreen> createState() => _SellerProductScreenState();
}

class _SellerProductScreenState extends State<SellerProductScreen> {
  final ScrollController _scrollController = ScrollController();
  AppLocalizations? _localizations;
  SellerProductScreenBloc? _productScreenBloc;
  bool isLoading = false;
  bool isFromPagination = false;
  SellerProductModel? productList;
  List<SellerProduct> sellerProducts = [];
  int offset = 0;
  bool isGridViewShowing = false;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _productScreenBloc = context.read<SellerProductScreenBloc>();
    _productScreenBloc?.add(SellerProductScreenDataFetchEvent(
        0, 10, widget.arg[stateKey]!, widget.arg[operatorKey]!));
    _scrollController.addListener(() {
      paginationFunction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonToolBar(
          _localizations?.translate(MarketplaceStringConstant.sellerProduct) ??
              '',
          context),
      body: BlocBuilder<SellerProductScreenBloc, SellerProductScreenState>(
          builder: (context, currentState) {
        if (currentState is SellerProductScreenInitialState) {
          if (!isFromPagination) {
            isLoading = true;
          }
        } else if (currentState is SellerProductScreenSuccess) {
          isLoading = false;
          isFromPagination = false;
          productList = currentState.products;
          if (offset == 0) {
            sellerProducts = productList?.sellerProduct ?? [];
          } else {
            sellerProducts.addAll(productList?.sellerProduct ?? []);
          }
        } else if (currentState is SellerProductScreenError) {
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
        if (sellerProducts.isNotEmpty)
          isLoading
              ? Loader()
              : Visibility(
                  visible: productList?.sellerProduct?.isNotEmpty ?? true,
                  child: SingleChildScrollView(
                      controller: _scrollController
                        ..addListener(() {
                          paginationFunction();
                        }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.imageRadius),
                        child: Column(
                          children: [
                            listView(sellerProducts),
                            Visibility(
                                visible: isFromPagination, child: Loader())
                          ],
                        ),
                      )),
                ),
        Visibility(
          visible: (sellerProducts.isEmpty && (!isLoading)),
          child:  Center(child: Text(_localizations?.translate(AppStringConstant.noProductFound) ?? '', style: Theme.of(context).textTheme.subtitle2,)),
        ),
        Visibility(visible: isLoading, child: Loader())
      ],
    );
  }

  Widget listView(List<SellerProduct> productList) {
    print('List Callback--${productList.length}');
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: productList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var data = productList;
          return sellerProductListItem(
            context,
            _localizations,
            data[index],
          );
        });
  }

  void paginationFunction() {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        (productList?.totalCount ?? 0) != sellerProducts.length) {
      setState(() {
        if ((offset + 10) < (productList?.totalCount ?? 0)) {
          offset += 10;

          _productScreenBloc?.add(SellerProductScreenDataFetchEvent(
              offset, 10, widget.arg[stateKey]!, widget.arg[operatorKey]!));

          isFromPagination = true;
        }
      });
    }
  }
}
