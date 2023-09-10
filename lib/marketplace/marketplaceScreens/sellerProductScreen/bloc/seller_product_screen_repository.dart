
import 'dart:convert';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerProductModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceNetworkManager/marketplace_api_client.dart';

abstract class SellerProductScreenRepository{
  Future<SellerProductModel> getProductList(int offset, int limit, String state, String operator);

}

class SellerProductScreenRepositoryImp implements SellerProductScreenRepository{

  @override
  Future<SellerProductModel> getProductList(int offset, int limit, String state, String operator) async{
    SellerProductModel? model;
    Map<String,dynamic> data = {};
    data["offset"] = offset;
    data["limit"] = limit;
      data['state'] = state;
      data['operator'] = operator;
    String body = json.encode(data);
    model = await MarketPlaceApiClient().getSellerProduct(body);
    return model;
  }

}