
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerDashboardModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceNetworkManager/marketplace_api_client.dart';

abstract class SellerDashboardScreenRepository{
  Future<SellerDashboardModel> getSellerDashboard();

}

class SellerDashboardScreenRepositoryImp implements SellerDashboardScreenRepository{

  @override
  Future<SellerDashboardModel> getSellerDashboard() async{
    SellerDashboardModel? model;
    model = await MarketPlaceApiClient().getSellerDashboard();
    return model;
  }
}