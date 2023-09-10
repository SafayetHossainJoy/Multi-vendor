
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_route_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstant/marketplace_arguments_map.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerProfileModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerDashboard/views/dashboard_card.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProfileScreen/bloc/seller_profile_screen_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProfileScreen/bloc/seller_profile_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProfileScreen/bloc/seller_profile_screen_state.dart';
import 'package:flutter_project_structure/screens/home/views/home_collection_view.dart';
import 'package:flutter_project_structure/screens/home/views/product_list_widgets/product_list_widgets.dart';


class SellerProfileScreen extends StatefulWidget {
  int sellerId;
   SellerProfileScreen( this.sellerId, {Key? key}) : super(key: key);

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  SellerProfileScreenBloc? _sellerProfileScreenBloc;
  SellerProfileModel? sellerProfile;
  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }
  @override
  void initState() {
    _sellerProfileScreenBloc = context.read<SellerProfileScreenBloc>();
    _sellerProfileScreenBloc?.add( SellerProfileScreenDataFetchEvent(widget.sellerId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: commonAppBar(_localizations?.translate(MarketplaceStringConstant.sellerProfile) ?? '', context),
      body: BlocBuilder<SellerProfileScreenBloc, SellerProfileScreenState>(
        builder: (context, state) {
          if(state is SellerProfileInitialState){
            isLoading = true;
          }
          else if(state is SellerProfileScreenSuccessState){
            isLoading = false;
            sellerProfile = state.data;
          }
          else if( state is SellerProfileScreenErrorState){
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
      visible: (sellerProfile?.sellersDetail  != null),
        child: SingleChildScrollView(
          child:  Column(
            children: [
              Stack(alignment: Alignment.center, children: [
                ImageView(
                  url: sellerProfile?.sellersDetail?.sellerProfileBanner,
                  height: AppSizes.height / 3.5,
                  width: AppSizes.width,
                  fit: BoxFit.fill,
                ),
               Container(
                 color: AppColors.lightGray,
                 padding: EdgeInsets.all(AppSizes.linePadding),
                 child: Column(
                   mainAxisSize:  MainAxisSize.min,
                   children: [
                     ImageView(
                       url: sellerProfile?.sellersDetail?.sellerProfileImage,
                        height: AppSizes.height / 5.8,
                       width: AppSizes.width / 4,
                     ),
                     Text(sellerProfile?.sellersDetail?.name ?? '', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: AppColors.white,)),
                     const SizedBox(height: AppSizes.linePadding,),
                     Text(sellerProfile?.sellersDetail?.country ?? '', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: AppColors.white),)
                   ],
                 ),
               )
              ]),
              const SizedBox(height: AppSizes.linePadding,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.extraPadding,horizontal: AppSizes.imageRadius),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_localizations?.translate(MarketplaceStringConstant.recentlyAddedProducts) ?? '', style: Theme.of(context).textTheme.headline4,),
                    Visibility(
                      visible: sellerProfile?.sellersDetail?.sellerProducts?.products?.isNotEmpty ?? false,
                      child: viewAllButton(context,(){
                        Navigator.pushNamed(context, catalogPage, arguments: catalogDataMap(10, 0, sellerProfile?.sellersDetail?.sellerId ?? 0, sellerProfile?.sellersDetail?.name ?? ''));
                      }),
                    )
                  ],
                ),
              ),
              (sellerProfile?.sellersDetail?.sellerProducts?.products?.isNotEmpty ?? false)
                  ? buildHorizontalProduct(sellerProfile?.sellersDetail?.sellerProducts?.products ?? [], _localizations)
                  : Text(_localizations?.translate(MarketplaceStringConstant.noProductMessage) ?? '', style: Theme.of(context).textTheme.subtitle2,) ,
              const SizedBox(height: AppSizes.extraPadding,),
              aboutSellerTile()
            ],
          ),
        )
    );
  }

  Widget aboutSellerTile( ){
    return Padding(
      padding: const EdgeInsets.all(AppSizes.imageRadius),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_localizations?.translate(MarketplaceStringConstant.aboutSeller) ?? '', style: Theme.of(context).textTheme.subtitle2,),
          const Divider(
            height: AppSizes.linePadding,
          ),
          listItem(context, _localizations?.translate(MarketplaceStringConstant.ratingAndReview) ?? '', '', (){
            Navigator.pushNamed(context, sellerReview, arguments: sellerDetails(sellerProfile?.sellersDetail?.sellerId ?? 0, sellerProfile?.sellersDetail?.name ?? ''));
          }),
          const Divider(
            height: AppSizes.linePadding,
          ),
          listItem(context, _localizations?.translate(MarketplaceStringConstant.returnPolicy) ?? '', '', (){
            Navigator.pushNamed(context, policy, arguments: sellerPolicy(_localizations?.translate(MarketplaceStringConstant.returnPolicy) ?? '', sellerProfile?.sellersDetail?.returnPolicy ?? ''));
          }),
          const Divider(
            height: AppSizes.linePadding,
          ),
          listItem(context, _localizations?.translate(MarketplaceStringConstant.shippingPolicy) ?? '', '', (){
            Navigator.pushNamed(context, policy, arguments: sellerPolicy(_localizations?.translate(MarketplaceStringConstant.shippingPolicy) ?? '', sellerProfile?.sellersDetail?.shippingPolicy ?? ''));
          }),
        ],
      ),
    );
  }
}

