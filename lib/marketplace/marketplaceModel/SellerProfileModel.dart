
import 'package:flutter_project_structure/marketplace/marketplaceModel/MarketPlaceModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'SellerProfileModel.g.dart';

@JsonSerializable()
class SellerProfileModel extends BaseModel {
  Addons? addons;
  int? customerId;
  int? userId;
  int? cartCount;
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
  @JsonKey(name: "SellerInfo")
  SellersDetail? sellersDetail;
  SellerProfileModel({
    this.itemsPerPage,this.customerId,this.addons,this.cartCount,this.isEmailVerified, this.isSeller, this.sellerGroup, this.sellerState, this.userId, this.wishlistCount
  });
  factory SellerProfileModel.fromJson(Map<String, dynamic> json) =>
      _$SellerProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$SellerProfileModelToJson(this);

}