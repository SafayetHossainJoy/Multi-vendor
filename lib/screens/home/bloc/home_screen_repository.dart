
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/encryption.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class HomeScreenRepository {
  Future<HomePageData> getHomeData();
}

class HomeScreenRepositoryImp implements HomeScreenRepository {
  @override
  Future<HomePageData> getHomeData() async {
    HomePageData? model;
   model = await ApiClient().getHomePageData(generateEncodedApiKey(ApiConstant.baseData));
    return model;
  }
}
