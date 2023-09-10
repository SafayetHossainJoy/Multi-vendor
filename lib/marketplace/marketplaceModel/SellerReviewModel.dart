import 'package:flutter_project_structure/marketplace/marketplaceModel/MarketPlaceModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'SellerReviewModel.g.dart';

@JsonSerializable()
class SellerReviewModel extends BaseModel {
  Addons? addons;
  int? customerId;
  int? userId;
  int? cartCount;
  @JsonKey(name: "WishlistCount")
  int? wishlistCount;
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  @JsonKey(name: "is_seller")
  bool? isSeller;
  @JsonKey(name: "seller_group")
  String? sellerGroup;
  @JsonKey(name: "seller_state")
  String? sellerState;
  int? itemsPerPage;
  @JsonKey(name: "SellerReview")
  List<SellerReviews>? sellerReview;
  int? sellerReviewCount;
  @JsonKey(name: "seller_image")
  String? sellerImage;
  @JsonKey(name: "seller_profile_image")
  String? sellerProfileImage;
  SellerReviewModel({
    this.itemsPerPage,this.customerId,this.addons,this.cartCount,this.isEmailVerified, this.isSeller, this.sellerGroup, this.sellerState, this.userId, this.wishlistCount, this.sellerReview, this.sellerProfileImage, this.sellerImage, this.sellerReviewCount
  });
  factory SellerReviewModel.fromJson(Map<String, dynamic> json) =>
      _$SellerReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$SellerReviewModelToJson(this);

}