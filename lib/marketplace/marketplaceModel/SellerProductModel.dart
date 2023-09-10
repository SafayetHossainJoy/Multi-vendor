
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'SellerProductModel.g.dart';

@JsonSerializable()
class SellerProductModel extends BaseModel{
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
  @JsonKey(name: "tcount")
  int? totalCount;
  List<SellerProduct>? sellerProduct;

  SellerProductModel({
    this.wishlistCount,this.userId, this.sellerState, this.sellerGroup, this.isSeller, this.isEmailVerified, this.cartCount, this.addons, this.customerId, this.itemsPerPage, this.totalCount, this.sellerProduct
});
  factory SellerProductModel.fromJson(Map<String, dynamic> json) =>
      _$SellerProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$SellerProductModelToJson(this);

}

@JsonSerializable()
class SellerProduct{
  String? state;
  String? thumbNail;
  String? seller;
  String? name;
  String? priceUnit;
  double? qty;
  int? templateId;
  SellerProduct({this.state, this.priceUnit, this.name, this.thumbNail, this.qty, this.seller,this.templateId});

  factory SellerProduct.fromJson(Map<String, dynamic> json) =>
      _$SellerProductFromJson(json);

  Map<String, dynamic> toJson() => _$SellerProductToJson(this);
}