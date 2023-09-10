
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'SellerDashboardModel.g.dart';

@JsonSerializable()
class SellerDashboardModel extends BaseModel {
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
  @JsonKey(name: "sellerDashboard")
  SellerDashboard? sellerDashboard;

  SellerDashboardModel({
    this.itemsPerPage,this.customerId,this.addons,this.cartCount,this.isEmailVerified, this.isSeller, this.sellerGroup, this.sellerState, this.userId, this.wishlistCount, this.sellerDashboard
});
  factory SellerDashboardModel.fromJson(Map<String, dynamic> json) =>
      _$SellerDashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$SellerDashboardModelToJson(this);

}

@JsonSerializable()
class SellerDashboard{
  @JsonKey(name: "approved_productCount")
  int? approvedProductCount;
  @JsonKey(name: "approved_solCount")
  int? approvedOrderCount;
  @JsonKey(name: "new_solCount")
  int? newOrderCount;
  @JsonKey(name: "pending_productCount")
  int? pendingProductCount;
  @JsonKey(name: "rejected_productCount")
  int? rejectedProductCount;
  @JsonKey(name: "shipped_solCount")
  int? shippedOrderCount;
  Total? total;
  Total? balance;

  SellerDashboard({
    this.total, this.approvedOrderCount,this.approvedProductCount, this.balance, this.newOrderCount, this.pendingProductCount, this.rejectedProductCount, this.shippedOrderCount
});
  factory SellerDashboard.fromJson(Map<String, dynamic> json) =>
      _$SellerDashboardFromJson(json);

  Map<String, dynamic> toJson() => _$SellerDashboardToJson(this);
}

@JsonSerializable()
class Total{
  String? label;
  double? value;

  Total({this.value, this.label});
  factory Total.fromJson(Map<String, dynamic> json) =>
      _$TotalFromJson(json);

  Map<String, dynamic> toJson() => _$TotalToJson(this);
}