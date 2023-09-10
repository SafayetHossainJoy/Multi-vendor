
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_switch_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_text_field.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SignUpDetailsModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_bloc.dart';

import '../../config/theme.dart';


class MarketPlaceSignUpOption extends StatefulWidget {
  List<Countries> countryList;
  ValueChanged<SignUpDetails> callback;
  // SigninSignupScreenBloc? bloc;
  VoidCallback termsCallback;
  bool isFromMarketplace;
   MarketPlaceSignUpOption(this.countryList, this.callback, this.termsCallback, {Key? key, this.isFromMarketplace = false}) : super(key: key);

  @override
  State<MarketPlaceSignUpOption> createState() => _MarketPlaceSignUpOptionState();
}

class _MarketPlaceSignUpOptionState extends State<MarketPlaceSignUpOption> {
  AppLocalizations? localizations;
  SignUpDetails data = SignUpDetails(becomeASeller: false,acceptConditions: false, hasState: false, countryId: 0, stateId: 0, profileUrl: '' );
  TextEditingController profileController = TextEditingController();

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (widget.isFromMarketplace)
            ? Container()
            : CommonSwitchButton(
            localizations
                ?.translate(MarketplaceStringConstant.sellerOption) ??
                '',(value){
              setState(() {
                data.becomeASeller = value;
                widget.callback(data);
              });
          // callback!();
        }, data.becomeASeller!),

        Visibility(
          visible: (data.becomeASeller ?? false) || (widget.isFromMarketplace),
          child: Column(
            children: [
              DropdownButtonFormField<Countries>(
                elevation: 0,
                // value: selectedCountry,
                menuMaxHeight: AppSizes.height / 2,
                dropdownColor: MobikulTheme.lightGrey,
                decoration: formFieldDecoration(context, "", localizations?.translate(AppStringConstant.country) ?? '',
                    isDense: true, isRequired: true,),
                items: (widget.countryList).map((Countries optionData) {
                  return DropdownMenuItem(

                    child: Text(
                      optionData.name ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    value: optionData,
                  );
                }).toList(),
                onChanged: (value) {
                  print('dadads---Edit');
                  setState(() {
                    data.countryId = value?.id;
                    widget.callback(data);
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return localizations?.translate(AppStringConstant.required);
                  }
                },
              ),
              const SizedBox(
                height: AppSizes.sidePadding,
              ),
              CommonTextField(
                controller: profileController,
                isRequired: true,
                isPassword: false,
                hintText: localizations?.translate(MarketplaceStringConstant.profileUrl) ?? '',
                inputType: TextInputType.name,
                onChange: (value){
                  data.profileUrl = profileController.text;
                  widget.callback(data);
                },
                validationType:  MarketplaceStringConstant.profileUrl,

              ),
              const SizedBox(
                height: AppSizes.sidePadding,
              ),
              CommonSwitchButton(
                  localizations
                      ?.translate(AppStringConstant.agreeTermAndCondition) ??
                      '',(value){
                    setState(() {
                      data.acceptConditions = value;
                      widget.callback(data);
                    });

                // callback!();
              }, data.acceptConditions!),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        widget.termsCallback();
                       // widget.bloc?.add(const SellerSignUpTermsEvent());
                       print('callback------------');
                      },
                      child: Text(
                          (localizations
                              ?.translate(AppStringConstant.viewTerms) ??
                              ''),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: AppColors.textBlue))),
                ],
              ),
              const SizedBox(
                height: AppSizes.sidePadding,
              ),
            ],
          ),
        ),

      ],
    );
  }
}