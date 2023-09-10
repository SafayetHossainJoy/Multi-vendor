
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'AskToAdminModel.g.dart';

@JsonSerializable()
class AskToAdminModel extends BaseModel{
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

  AskToAdminModel({
    this.customerId,this.addons,this.cartCount,this.isEmailVerified,this.isSeller,this.sellerGroup,this.sellerState,this.userId,this.wishlistCount
});
  factory AskToAdminModel.fromJson(Map<String, dynamic> json) =>
      _$AskToAdminModelFromJson(json);

  Map<String, dynamic> toJson() => _$AskToAdminModelToJson(this);
}
