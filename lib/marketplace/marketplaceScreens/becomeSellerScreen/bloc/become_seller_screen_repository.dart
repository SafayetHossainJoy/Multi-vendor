import 'dart:convert';

import 'package:flutter_project_structure/marketplace/marketplaceNetworkManager/marketplace_api_client.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/SignUpTermsModel.dart';

import '../../../../models/CountryListModel.dart';

abstract class BecomeSellerScreenRepository{
  Future<CountryListModel> getCountryList();
  Future<SignUpTermsModel> getSellerTerms();
  Future<BaseModel> registerSeller(int countryId, String profileUrl);

}

class BecomeSellerScreenRepositoryImp implements BecomeSellerScreenRepository{
  @override
  Future<CountryListModel> getCountryList() async {
    CountryListModel model;
    model = await MarketPlaceApiClient().getCountryList();
    return model;
  }

  @override
  Future<BaseModel> registerSeller(int countryId, String profileUrl)async {
    BaseModel model;
    Map<String, dynamic> data = <String, dynamic>{};
    data['url_handler'] = profileUrl;
    data['country_id'] = countryId;
    String body = json.encode(data);
    model = await MarketPlaceApiClient().registerAsSeller(body);
    return model;
  }

  // {"url_handler":"demourl","country_id":"104"}
  @override
  Future<SignUpTermsModel> getSellerTerms()async{
    SignUpTermsModel model = await MarketPlaceApiClient().getSellerTermsAndConditions();
    return model;
  }
}