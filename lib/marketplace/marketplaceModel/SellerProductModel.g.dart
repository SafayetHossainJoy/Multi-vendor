// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SellerProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerProductModel _$SellerProductModelFromJson(Map<String, dynamic> json) =>
    SellerProductModel(
      wishlistCount: json['WishlistCount'] as int?,
      userId: json['userId'] as int?,
      sellerState: json['seller_state'] as String?,
      sellerGroup: json['seller_group'] as String?,
      isSeller: json['is_seller'] as bool?,
      isEmailVerified: json['is_email_verified'] as bool?,
      cartCount: json['cartCount'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      customerId: json['customerId'] as int?,
      itemsPerPage: json['itemsPerPage'] as int?,
      totalCount: json['tcount'] as int?,
      sellerProduct: (json['sellerProduct'] as List<dynamic>?)
          ?.map((e) => SellerProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$SellerProductModelToJson(SellerProductModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'addons': instance.addons,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'WishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'seller_group': instance.sellerGroup,
      'seller_state': instance.sellerState,
      'itemsPerPage': instance.itemsPerPage,
      'tcount': instance.totalCount,
      'sellerProduct': instance.sellerProduct,
    };

SellerProduct _$SellerProductFromJson(Map<String, dynamic> json) =>
    SellerProduct(
      state: json['state'] as String?,
      priceUnit: json['priceUnit'] as String?,
      name: json['name'] as String?,
      thumbNail: json['thumbNail'] as String?,
      qty: (json['qty'] as num?)?.toDouble(),
      seller: json['seller'] as String?,
      templateId: json['templateId'] as int?,
    );

Map<String, dynamic> _$SellerProductToJson(SellerProduct instance) =>
    <String, dynamic>{
      'state': instance.state,
      'thumbNail': instance.thumbNail,
      'seller': instance.seller,
      'name': instance.name,
      'priceUnit': instance.priceUnit,
      'qty': instance.qty,
      'templateId': instance.templateId,
    };
