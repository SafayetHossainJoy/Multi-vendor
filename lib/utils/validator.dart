import 'package:flutter_project_structure/constants/app_string_constant.dart';

import '../marketplace/marketplaceConstants/marketplace_string_constant.dart';

class Validator {
  static bool isEmpty(String value) {
    return value.isEmpty;
  }

  static String? isEmailValid(String email) {
    var emailRegExp = RegExp("[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+");
    if (isEmpty(email)) {
      return AppStringConstant.emailRequired;
    } else if (!emailRegExp.hasMatch(email)) {
      return AppStringConstant.validEmail;
    }
    return null;
  }

  static String? isValidPassword(String password) {
    if (isEmpty(password)) {
      return AppStringConstant.passwordRequired;
    } else if (password.trim().length <= 5) {
      return AppStringConstant.invalidPasswordMessage;
    }
    return null;
  }
  static String? isProfileUrl(String profileurl){
    var profilRegExp = RegExp("^[a-zA-Z0-9_-]*\$");
    //RegExp("[a-zA-Z0-9_-]");
    if(isEmpty(profileurl)){
      return MarketplaceStringConstant.profileUrlRequred;
    } else if(!profilRegExp.hasMatch(profileurl)){
      return MarketplaceStringConstant.invalidProfilUrl;
    } return null;
  }

}
