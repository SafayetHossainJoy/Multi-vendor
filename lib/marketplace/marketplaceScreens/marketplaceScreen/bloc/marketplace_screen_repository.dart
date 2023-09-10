import 'package:flutter_project_structure/marketplace/marketplaceModel/MarketPlaceModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceNetworkManager/marketplace_api_client.dart';

abstract class MarketplaceScreenRepository{
  Future<MarketPlaceModel> getMarketplace();

}

class MarketplaceScreenRepositoryImp implements MarketplaceScreenRepository{

  @override
  Future<MarketPlaceModel> getMarketplace() async{
    MarketPlaceModel model;
    model = await MarketPlaceApiClient().getMarketPlace();
    return model;
  }
}