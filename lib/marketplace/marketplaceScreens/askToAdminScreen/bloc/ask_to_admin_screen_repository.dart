
import 'dart:convert';
import 'package:flutter_project_structure/marketplace/marketplaceModel/AskToAdminModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceNetworkManager/marketplace_api_client.dart';

abstract class AskToAdminRepository {
  Future<AskToAdminModel> onAsk(String title, String body);
}

class AskToAdminRepositoryImp implements AskToAdminRepository {
  @override
  Future<AskToAdminModel> onAsk(
    String title, String comment) async {
    AskToAdminModel? model;
    Map<String, dynamic> data = {};
    data["title"] = title;
    data["body"] = comment;
    String body = json.encode(data);
    model = await MarketPlaceApiClient().onAsk( body);
    return model;
  }
}
