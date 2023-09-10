
import 'dart:convert';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerOrderModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceNetworkManager/marketplace_api_client.dart';

abstract class SellerOrderScreenRepository{
  Future<SellerOrderModel> getOrderList(int offset, int limit, String state);

}

class SellerOrderScreenRepositoryImp implements SellerOrderScreenRepository{

  @override
  Future<SellerOrderModel> getOrderList(int offset, int limit, String state) async{
    SellerOrderModel? model;
    Map<String,dynamic> data = {};
    data["offset"] = offset;
    data["limit"] = limit;
    if(state != ''){
      data['state'] = state;
    }
    String body = json.encode(data);
    model = await MarketPlaceApiClient().getSellerOrder(body);
    return model;
  }

}