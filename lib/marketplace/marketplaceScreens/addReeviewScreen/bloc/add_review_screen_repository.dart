import 'dart:convert';
import 'package:flutter_project_structure/marketplace/marketplaceNetworkManager/marketplace_api_client.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';

abstract class AddReviewRepository {
  Future<BaseModel> addSellerReview(int sellerId, double rating, String title, String review);
}

class AddReviewRepositoryImp implements AddReviewRepository {
  @override
  Future<BaseModel> addSellerReview(int sellerId, double rating, String title, String review) async {
    BaseModel? model;
    Map<String, dynamic> data = {};
    data["title"] = title;
    data["msg"] = review;
    data['rating'] = rating;
    String body = json.encode(data);
    model = await MarketPlaceApiClient().addSellerReview( sellerId, body);
    return model;
  }
}
