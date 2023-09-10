
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_text_field.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/marketplace/marketplaceConstants/marketplace_string_constant.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/AskToAdminModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/askToAdminScreen/bloc/ask_to_admin_screen_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/askToAdminScreen/bloc/ask_to_admin_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/askToAdminScreen/bloc/ask_to_admin_screen_state.dart';
import 'package:flutter_project_structure/utils/helper.dart';

class AskToAdminScreen extends StatefulWidget {
  const AskToAdminScreen({Key? key}) : super(key: key);

  @override
  State<AskToAdminScreen> createState() => _AskToAdminScreenState();
}

class _AskToAdminScreenState extends State<AskToAdminScreen> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  AppLocalizations? _localizations;
  bool isLoading = false;
AskToAdminModel? data;
AskToAdminBloc? _askToAdminBloc;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void didChangeDependencies() {
   _localizations  =AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _askToAdminBloc = context.read<AskToAdminBloc>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(_localizations?.translate(MarketplaceStringConstant.askToAdmin) ?? '', context),
      body: BlocBuilder<AskToAdminBloc, AskToAdminScreenState>(
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
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.imageRadius, vertical: AppSizes.buttonRadius),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CommonTextField(
                      controller: subjectController,
                      isRequired: true,
                      isPassword: false,
                      hintText: _localizations
                          ?.translate(MarketplaceStringConstant.subject) ??
                          "",
                    ),

                    const SizedBox(height: AppSizes.extraPadding *2),
                    CommonTextField(
                      controller: commentController,
                      isRequired: true,
                      isPassword: false,
                      isDense: false,
                      hintText:
                      _localizations?.translate(MarketplaceStringConstant.comment) ??
                          "",
                      inputType: TextInputType.multiline,
                    ),

                    const SizedBox(height: AppSizes.extraPadding * 1.5),

                  ],
                ),
              ),
            ),
          ),
          commonButton(
              context,
              _validateForm,
              (_localizations?.translate(MarketplaceStringConstant.ask) ?? ""),
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              textColor: Theme.of(context).colorScheme.secondaryContainer),

          const SizedBox(height: AppSizes.extraPadding),
        ],
      ),
    );
 }

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      Helper.hideSoftKeyBoard();
      _askToAdminBloc?.add(AskEvent(subjectController.text, commentController.text));
    }
  }

}
