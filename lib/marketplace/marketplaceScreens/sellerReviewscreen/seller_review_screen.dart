import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstant/marketplace_arguments_map.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_route_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/MarketPlaceModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerReviewModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/SellerReviewscreen/bloc/seller_review_screen_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/SellerReviewscreen/bloc/seller_review_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/SellerReviewscreen/bloc/seller_review_screen_state.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/SellerReviewscreen/views/review_list_item.dart';
import '../../../constants/app_constants.dart';
import '../../../helper/image_view.dart';

class SellerReviewScreen extends StatefulWidget {
  Map<String, dynamic> args;

  SellerReviewScreen(this.args, {Key? key}) : super(key: key);

  @override
  State<SellerReviewScreen> createState() => _SellerReviewScreenState();
}

class _SellerReviewScreenState extends State<SellerReviewScreen> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  bool showProfile = false;
  SellerReviewScreenBloc? _sellerReviewScreenBloc;
  SellerReviewModel? reviewData;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _sellerReviewScreenBloc = context.read<SellerReviewScreenBloc>();
    _sellerReviewScreenBloc
        ?.add(SellerReviewScreenDataFetchEvent(widget.args[sellerIdKey]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          "${widget.args[sellerNameKey]} ${_localizations?.translate(AppStringConstant.reviews) ?? ''}",
          context),
      body: BlocBuilder<SellerReviewScreenBloc, SellerReviewScreenState>(
          builder: (context, state) {
        if (state is SellerReviewInitialState) {
          isLoading = true;
        } else if (state is SellerReviewScreenSuccessState) {
          isLoading = false;
          reviewData = state.data;
          showProfile = true;
        } else if (state is SellerReviewScreenErrorState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message, context);
          });
        }
        else if(state is SellerLikeDislikeReviewState){
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(state.data.message ?? '', context);
          });
          _sellerReviewScreenBloc?.add(SellerReviewScreenDataFetchEvent(widget.args[sellerIdKey]));
        }
        return Stack(children: [
          buildUi(),
          Visibility(visible: isLoading, child: Loader())
        ]);
      }),
    );
  }

  Widget buildUi() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: (showProfile),
            child: Container(
              margin: const EdgeInsets.all(AppSizes.linePadding),
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.all(AppSizes.extraPadding),
              child: Row(
                children: [
                  Container(
                      height: AppSizes.height / 8,
                      width: AppSizes.height / 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: MobikulTheme.accentColor, width: 2.0)),
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppSizes.height / 8),
                          child: ImageView(
                            url: reviewData?.sellerImage,
                            fit: BoxFit.fill,
                          ))),
                  const SizedBox(
                    width: AppSizes.extraPadding,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.args[sellerNameKey].toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: AppSizes.imageRadius,
                      ),
                      commonButton(
                        context,
                        () {
                          (AppSharedPref().getIfLogin() != null &&
                              AppSharedPref().getIfLogin() == true) ?
                          Navigator.pushNamed(context, addReview, arguments: widget.args[sellerIdKey]).then((value) {
                            if((value ?? false) as bool){
                              _sellerReviewScreenBloc
                                  ?.add(SellerReviewScreenDataFetchEvent(widget.args[sellerIdKey]));
                            }
                          }):
                          DialogHelper.confirmationDialog(
                              "${_localizations?.translate(AppStringConstant.signInToContinue)}",
                              context,
                              _localizations, onConfirm: () async {
                            Navigator.pushNamed(context, loginSignup,
                                arguments: false);
                          });
                        },
                        _localizations
                                ?.translate(AppStringConstant.writeAReview) ??
                            '',
                        width: AppSizes.width / 2,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Visibility(
              visible: (reviewData?.sellerReview != null),
              child: productReviewList(reviewData?.sellerReview))
        ],
      ),
    );
  }

  Widget productReviewList(List<SellerReviews>? productReviews) {
    return ((productReviews != null)
        ? Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.normalPadding,
                horizontal: AppSizes.imageRadius),
            child: ListView.builder(
                itemCount: productReviews.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = productReviews[index];
                  return reviewListItemCard(
                      data,
                      context,
                      likeDislikeFunction(data.id!, true),
                      likeDislikeFunction(data.id!, false));
                }),
          )
        : Container());
  }

  GestureTapCallback likeDislikeFunction(int reviewId, bool isHelpful) => () {
        if (AppSharedPref().getIfLogin() != null &&
            AppSharedPref().getIfLogin() == true) {
          _sellerReviewScreenBloc
              ?.add(SellerReviewLikeDislikeEvent(reviewId, isHelpful));
        }
      };
}
