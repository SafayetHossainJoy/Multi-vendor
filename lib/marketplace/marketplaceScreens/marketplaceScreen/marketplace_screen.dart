
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_route_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/MarketPlaceModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/marketplaceScreen/bloc/marketplace_screen_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/marketplaceScreen/bloc/marketplace_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/marketplaceScreen/bloc/marketplace_screen_state.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/marketplaceScreen/views/seller_details.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({Key? key}) : super(key: key);

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  MarketplaceScreenBloc? marketplaceScreenBloc;
  MarketPlaceModel? marketPlaceData;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    marketplaceScreenBloc = context.read<MarketplaceScreenBloc>();
    marketplaceScreenBloc?.add(const MarketplaceScreenDataFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          _localizations?.translate(MarketplaceStringConstant.marketplace) ?? '',
          context),
      body: BlocBuilder<MarketplaceScreenBloc, MarketplaceScreenState>(
          builder: (context, state) {
        if (state is MarketplaceInitialState) {
          isLoading = true;
        } else if (state is MarketplaceScreenSuccessState) {
          isLoading = false;
          marketPlaceData = state.data;
        } else if (state is MarketplaceScreenErrorState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message, context);
          });
        }
        return Stack(children: [
          buildUi(),
          Visibility(visible: isLoading, child: Loader())
        ]);
      }),
    );
  }

  Widget buildUi() {
    return Visibility(
        visible: (marketPlaceData?.sellersDetail != null),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(alignment: Alignment.center, children: [
                ImageView(
                  url: marketPlaceData?.banner,
                  height: AppSizes.height / 3.4,
                  width: AppSizes.width,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSizes.linePadding),
                      child: Text(
                        marketPlaceData?.heading ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                    Visibility(
                      visible: !(marketPlaceData?.isSeller ?? false),
                      child: commonButton(
                          context,
                          () {
                            if (AppSharedPref().getIfLogin() != null &&
                                AppSharedPref().getIfLogin() == true){
                              Navigator.pushNamed(context, becomeASeller);

                            }else{
                            DialogHelper.confirmationDialog(
                                "${_localizations?.translate(AppStringConstant.signInToContinue)}",
                                context,
                                _localizations, onConfirm: () async {
                              Navigator.pushNamed(context, loginSignup,
                                  arguments: false);
                            });}
                          },
                          _localizations?.translate(
                              MarketplaceStringConstant.becomeASeller) ??
                              '',
                          width: AppSizes.width / 5,
                          borderRadius: 30,
                          textColor: AppColors.white,
                          borderSideColor: AppColors.white),
                    ),
                  ],
                )
              ]),
              Padding(
                padding: const EdgeInsets.all(AppSizes.extraPadding),
                child: Text(_localizations?.translate(MarketplaceStringConstant.topSellers).toUpperCase() ?? '', style: Theme.of(context).textTheme.headline4,),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: marketPlaceData?.sellersDetail?.length ?? 0,
                  itemBuilder: (context, index) {
                    return sellerDetails(context, _localizations,
                        marketPlaceData?.sellersDetail?[index]);
                  })
            ],
          ),
        ));
  }
}
