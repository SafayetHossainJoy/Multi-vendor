
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'SellerOrderModel.g.dart';

@JsonSerializable()
class SellerOrderModel extends BaseModel{
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
  @JsonKey(name: "sellerOrderLines")
  List<SellerOrder>? sellerOrder;

  SellerOrderModel({
    this.wishlistCount,this.userId,this.sellerState,this.sellerGroup, this.isSeller, this.isEmailVerified,this.cartCount,this.addons,this.customerId,this.totalCount,this.itemsPerPage,this.sellerOrder
});

  factory SellerOrderModel.fromJson(Map<String, dynamic> json) =>
      _$SellerOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SellerOrderModelToJson(this);
}

@JsonSerializable()
class SellerOrder{
  @JsonKey(name: "create_date")
  String? createDate;
  String? customer;
  @JsonKey(name: "delivered_qty")
  double? deliveredQty;
  String? description;
  @JsonKey(name: "line_id")
  int? ineId;
  @JsonKey(name: "marketplace_state")
  String? marketplaceStatus;
  @JsonKey(name: "order_reference")
  int? orderReference;
  @JsonKey(name: "order_state")
  String? orderStatus;
  String? priceUnit;
  String? product;
  double? quantity;
  @JsonKey(name: "sub_total")
  String? subTotal;
  SellerOrder({this.product, this.quantity, this.description, this.orderStatus, this.createDate, this.customer, this.deliveredQty, this.ineId, this.marketplaceStatus, this.orderReference, this.priceUnit, this.subTotal});

  factory SellerOrder.fromJson(Map<String, dynamic> json) =>
      _$SellerOrderFromJson(json);

  Map<String, dynamic> toJson() => _$SellerOrderToJson(this);
}