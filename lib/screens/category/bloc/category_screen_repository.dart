
import 'dart:convert';

import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/encryption.dart';
import '../../../models/HomeScreenModel.dart';

abstract class CategoryScreenRepository {
  Future<CategoryScreenModel> getCategoryPage(int cid, int limit, int offset);

  Future<HomePageData> getHomeData();
}

class CategoryScreenRepositoryImp implements CategoryScreenRepository {
  @override
  Future<CategoryScreenModel> getCategoryPage(
      int cid, int limit, int offset) async {
    CategoryScreenModel? model;
    Map<String, dynamic> data = {};
    data["cid"] = cid;
    data["limit"] = limit;
    data["offset"] = offset;

    String body = json.encode(data);
    print(body);
    model = await ApiClient().getCatalogData(body);
    return model;
  }

  @override
  Future<HomePageData> getHomeData() async {
    HomePageData? model;
    model = await ApiClient()
        .getHomePageData(generateEncodedApiKey(ApiConstant.baseData));
    return model;
  }
}
