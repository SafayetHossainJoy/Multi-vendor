
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerProfileModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceNetworkManager/marketplace_api_client.dart';

abstract class SellerProfileScreenRepository{
  Future<SellerProfileModel> getSellerProfile(int sellerId);

}

class SellerProfileScreenRepositoryImp implements SellerProfileScreenRepository{

  @override
  Future<SellerProfileModel> getSellerProfile(int sellerId) async{
    SellerProfileModel? model;
    model = await MarketPlaceApiClient().getSellerDetails(sellerId);
    return model;
  }
}