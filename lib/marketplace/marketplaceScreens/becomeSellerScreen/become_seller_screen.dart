
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/marketplace/helpers/marketplace_signup_option.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SignUpDetailsModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/becomeSellerScreen/bloc/become_seller_screen_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/becomeSellerScreen/bloc/become_seller_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/becomeSellerScreen/bloc/become_seller_screen_state.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/utils/helper.dart';

class BecomeSellerScreen extends StatefulWidget {
  BecomeSellerScreen( {Key? key}) : super(key: key);

  @override
  State<BecomeSellerScreen> createState() => _BecomeSellerScreenState();
}

class _BecomeSellerScreenState extends State<BecomeSellerScreen> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  bool acceptTerms = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  BecomeSellerScreenBloc? _becomeSellerScreenBloc;
  CountryListModel? countryData;
  SignUpDetails sellerDetails = SignUpDetails();
  String? profileUrl;
  int? countryId;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _becomeSellerScreenBloc = context.read<BecomeSellerScreenBloc>();
   _becomeSellerScreenBloc?.add(BecomeSellerScreenInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          " ${_localizations?.translate(MarketplaceStringConstant.becomeASeller) ?? ''}",
          context),
      body: BlocBuilder<BecomeSellerScreenBloc, BecomeSellerScreenState>(
          builder: (context, state) {
        if (state is BecomeSellerInitialState) {
          isLoading = true;
        } else if (state is BecomeSellerScreenSuccessState) {
          isLoading = false;
          countryData = state.data;
        } else if (state is BecomeSellerScreenErrorState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message, context);
          });
        }
        else if(state is BecomeSellerDetailsSuccessState){
          isLoading = false;
          if(state.data.success ?? false){
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(state.data.message ?? '', context);
          });
          Future.delayed(Duration.zero,(){
            Navigator.pop(context);
          });}
          else{
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(state.data.message ?? '', context);
            });
          }
        }
        else if(state is BecomeSellerTermSuccessState){
          isLoading = false;
          Future.delayed(Duration.zero,(){
            DialogHelper.signUpTerms( (state.data.sellerTermsAndConditions ?? ''), context);
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
    return Form(
      key: _formKey ,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.extraPadding),
              child: MarketPlaceSignUpOption(countryData?.countries ?? [],(SignUpDetails data){
                acceptTerms = data.acceptConditions ?? false;
                countryId = data.countryId;
                profileUrl = data.profileUrl;

              }, (){
                _becomeSellerScreenBloc?.add(BecomeSellerTermsEvent());
              }, isFromMarketplace: true, ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.extraPadding),
              child: commonButton(
                  context, (){
                if(acceptTerms) {
                  if((sellerDetails.becomeASeller ?? false) &&(!(sellerDetails.acceptConditions ?? false))){
                    AlertMessage.showError(_localizations?.translate(AppStringConstant.acceptTermAndCondition)?? "", context);
                  }else{
                    if (_formKey.currentState?.validate() == true) {
                      Helper.hideSoftKeyBoard();
                      _becomeSellerScreenBloc?.add( BecomeSellerSaveDetailsEvent(countryId ?? 0,profileUrl ?? ''));
                    }
                  }
                } else{
                  AlertMessage.showError(_localizations?.translate(AppStringConstant.acceptTermAndCondition)?? "", context);
                }

              },
                  _localizations?.translate(MarketplaceStringConstant.register) ?? '',
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  textColor: Theme.of(context).colorScheme.secondaryContainer),
            )
          ],
        ),
      ),
    );
  }


}
