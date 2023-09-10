
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'MarketPlaceModel.g.dart';

@JsonSerializable()
class MarketPlaceModel extends BaseModel {
  Addons? addons;
  int? customerId;
  int? userId;
  int? cartCount;
  String? banner;
  String? heading;
  List? wishlist;
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
  @JsonKey(name: "SellersDetail")
  List<SellersDetail>? sellersDetail;
  MarketPlaceModel({
    this.itemsPerPage,this.customerId,this.addons,this.cartCount,this.isEmailVerified, this.isSeller, this.sellerGroup, this.sellerState, this.userId, this.wishlistCount
  });
  factory MarketPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$MarketPlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarketPlaceModelToJson(this);

}

@JsonSerializable()
class SellersDetail{
  @JsonKey(name: "average_rating")
  double? averageRating;
  String? country;
  @JsonKey(name: "create_date")
  String?  createDate;
  String? email;
  String? mobile;
  String? name;
  String? phone;
  @JsonKey(name: "product_count")
  int? productCount;
  @JsonKey(name: "product_msg")
  String? productMessage;
  @JsonKey(name: "return_policy")
  String? returnPolicy;
  @JsonKey(name: "sales_count")
  double? salesCount;
  @JsonKey(name: "seller_id")
  int? sellerId;
  @JsonKey(name: "seller_profile_banner")
  String? sellerProfileBanner;
  @JsonKey(name: "seller_profile_image")
  String? sellerProfileImage;
  @JsonKey(name: "seller_reviews")
  List<SellerReviews>? sellerReviews;
  @JsonKey(name: "shipping_policy")
  String? shippingPolicy;
  @JsonKey(name: "total_reviews")
  int? totalReviews;
  String? state;
  SellerProducts? sellerProducts;

  SellersDetail({this.email, this.createDate, this.name, this.sellerProducts,this.state, this.country,this.averageRating, this.mobile, this.phone, this.productCount, this.productMessage, this.returnPolicy, this.salesCount, this.sellerId, this.sellerProfileBanner, this.sellerProfileImage, this.sellerReviews, this.shippingPolicy, this.totalReviews, });
  factory SellersDetail.fromJson(Map<String, dynamic> json) =>
      _$SellersDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SellersDetailToJson(this);
}

@JsonSerializable()
class SellerReviews{
  @JsonKey(name: "create_date")
  String? createDate;
  @JsonKey(name: "display_name")
  String?displayName;
  dynamic email;
  int? helpful;
  int? id;
  String? image;
  @JsonKey(name: "message_is_follower")
  bool? messageIsFollower;
  String? msg;
  String? name;
  @JsonKey(name: "not_helpful")
  int? notHelpful;
  int? rating;
  String? title;
  @JsonKey(name: "total_votes")
  int? totalVote;

  SellerReviews({
    this.name, this.title, this.createDate, this.id, this.image, this.rating, this.displayName, this.email, this.helpful, this.messageIsFollower, this.msg, this.notHelpful, this.totalVote
});
  factory SellerReviews.fromJson(Map<String, dynamic> json) =>
      _$SellerReviewsFromJson(json);

  Map<String, dynamic> toJson() => _$SellerReviewsToJson(this);
}

@JsonSerializable()
class SellerProducts{
    int? offset;
    @JsonKey(name: "tcount")
    int? totalCount;
    List<Products>? products;
    SellerProducts({
    this.totalCount, this.products, this.offset
});
    factory SellerProducts.fromJson(Map<String, dynamic> json) =>
        _$SellerProductsFromJson(json);

    Map<String, dynamic> toJson() => _$SellerProductsToJson(this);

}

