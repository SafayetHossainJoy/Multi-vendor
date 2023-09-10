import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'HomeScreenModel.dart';
part 'PlaceOrderModel.g.dart';

@JsonSerializable()
class PlaceOrderModel extends BaseModel{
  Addons? addons;
  String? name;
  @JsonKey(name: 'txn_msg')
  String? txnMsg;
  String? url;
  @JsonKey(name: 'transaction_id')
  int? transactionId;
  int? cartCount;

  PlaceOrderModel({this.addons,this.name,this.txnMsg, this.transactionId, this.url, this.cartCount});

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderModelFromJson(json);
}