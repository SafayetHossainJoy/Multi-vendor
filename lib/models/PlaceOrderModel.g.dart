// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlaceOrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderModel _$PlaceOrderModelFromJson(Map<String, dynamic> json) =>
    PlaceOrderModel(
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      name: json['name'] as String?,
      txnMsg: json['txn_msg'] as String?,
      transactionId: json['transaction_id'] as int?,
      url: json['url'] as String?,
      cartCount: json['cartCount'] as int?,
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$PlaceOrderModelToJson(PlaceOrderModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'addons': instance.addons,
      'name': instance.name,
      'txn_msg': instance.txnMsg,
      'url': instance.url,
      'transaction_id': instance.transactionId,
      'cartCount': instance.cartCount,
    };
