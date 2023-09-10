
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_text_field.dart';
import 'package:flutter_project_structure/customWidgtes/rating_bar.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/addReeviewScreen/bloc/add_review_screen_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/addReeviewScreen/bloc/add_review_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/addReeviewScreen/bloc/add_review_screen_state.dart';
import 'package:flutter_project_structure/utils/helper.dart';

class AddReviewScreen extends StatefulWidget {
  int sellerId;
   AddReviewScreen(this.sellerId,{Key? key}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  AppLocalizations? _localizations;
  bool isLoading = false;
  double rating = 0.0;

  AddReviewBloc? _addReviewBloc;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void didChangeDependencies() {
   _localizations  =AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _addReviewBloc = context.read<AddReviewBloc>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(_localizations?.translate(AppStringConstant.addReview) ?? '', context),
      body: BlocBuilder<AddReviewBloc, AddReviewScreenState>(
        builder: (context, state){
          if(state is LoadingState){
            isLoading = true;
          }
          else if(state is SuccessState){
            isLoading = false;
            if (state.data.success ?? false) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Navigator.pop(context, true);
                AlertMessage.showSuccess(state.data.message ?? '', context);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(state.data.message ?? '', context);
              });
            }
          }
          else if(state is ErrorState){
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(state.message, context);
            });
          }
          return _buildUI();
        },
      ),
    );
  }

  Widget _buildUI(){
    return Stack(
      children: [
        formField(),
        Visibility(
          visible: isLoading,
            child: Loader())
      ],
    );
  }

 Widget formField(){
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.imageRadius),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSizes.imageRadius,
                    ),
                    Text(
                        _localizations?.translate(MarketplaceStringConstant.youAreReviewing) ?? "",
                        style: Theme.of(context).textTheme.headline4),
                    const SizedBox(
                      height: AppSizes.imageRadius,
                    ),
                    Text(AppSharedPref().getUserData()?.name ?? '',style: Theme.of(context).textTheme.headline3),
                    const SizedBox(
                      height: AppSizes.imageRadius,
                    ),
                    Text(
                        _localizations?.translate(AppStringConstant.rating) ?? "",
                        style: Theme.of(context).textTheme.headline4),
                    RatingBar(
                      starCount: 5,
                      color: AppColors.yellow,
                      rating: rating,
                      onRatingChanged: (_rating) {
                        rating = _rating;
                      },
                    ),
                    const SizedBox(height: AppSizes.extraPadding *2),

                    CommonTextField(
                      controller: titleController,
                      isRequired: true,
                      isPassword: false,
                      hintText: _localizations
                          ?.translate(MarketplaceStringConstant.title) ??
                          "",
                    ),

                    const SizedBox(height: AppSizes.extraPadding *2),
                    CommonTextField(
                      controller: reviewController,
                      isRequired: true,
                      isPassword: false,
                      isDense: false,
                      hintText:
                      _localizations?.translate(AppStringConstant.reviews) ??
                          "",
                      inputType: TextInputType.multiline,
                    ),

                    const SizedBox(height: AppSizes.extraPadding * 1.5),

                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSizes.imageRadius),
          child: commonButton(
              context,
              _validateForm,
              (_localizations?.translate(AppStringConstant.addReview) ?? ""),
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              textColor: Theme.of(context).colorScheme.secondaryContainer),
        ),

        const SizedBox(height: AppSizes.extraPadding),
      ],
    );
 }

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      Helper.hideSoftKeyBoard();
      FocusManager.instance.primaryFocus?.unfocus();
      if (_formKey.currentState!.validate() && rating != 0.0) {
        _addReviewBloc?.add(AddReviewEvert(widget.sellerId, rating, titleController.text, reviewController.text));
      } else if (rating == 0.0) {
        AlertMessage.showError(
            _localizations
                ?.translate(AppStringConstant.selectRating) ??
                "",
            context);
      }

    }
  }

}
