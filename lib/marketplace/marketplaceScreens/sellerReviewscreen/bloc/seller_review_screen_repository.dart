

import 'dart:convert';

import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerReviewModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceNetworkManager/marketplace_api_client.dart';

abstract class SellerReviewScreenRepository{
  Future<SellerReviewModel> getSellerReview(int sellerId);
  Future<SellerReviewModel> likeDislikeReview(int reviewId, bool isHelpFul);

}

class SellerReviewScreenRepositoryImp implements SellerReviewScreenRepository{

  @override
  Future<SellerReviewModel> getSellerReview(int sellerId) async{
    SellerReviewModel? model;
    model = await MarketPlaceApiClient().getSellerReview(sellerId);
    return model;
  }

  @override
  Future<SellerReviewModel> likeDislikeReview(int reviewId, bool isHelpFul ) async{
    SellerReviewModel? model;
    Map<String,dynamic> data = {};
   data['ishelpful'] = isHelpFul ;
   data['review_id'] = reviewId;
    String body = json.encode(data);
    model = await MarketPlaceApiClient().likeDisLikeReview(reviewId, body);
    return model;
  }
}