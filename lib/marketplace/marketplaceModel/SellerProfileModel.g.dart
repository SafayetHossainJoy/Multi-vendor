// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SellerProfileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerProfileModel _$SellerProfileModelFromJson(Map<String, dynamic> json) =>
    SellerProfileModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      customerId: json['customerId'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      cartCount: json['cartCount'] as int?,
      isEmailVerified: json['is_email_verified'] as bool?,
      isSeller: json['is_seller'] as bool?,
      sellerGroup: json['seller_group'] as String?,
      sellerState: json['seller_state'] as String?,
      userId: json['userId'] as int?,
      wishlistCount: json['WishlistCount'] as int?,
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?
      ..wishlist = json['wishlist'] as List<dynamic>?
      ..sellersDetail = json['SellerInfo'] == null
          ? null
          : SellersDetail.fromJson(json['SellerInfo'] as Map<String, dynamic>);

Map<String, dynamic> _$SellerProfileModelToJson(SellerProfileModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'addons': instance.addons,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'wishlist': instance.wishlist,
      'WishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'seller_group': instance.sellerGroup,
      'seller_state': instance.sellerState,
      'itemsPerPage': instance.itemsPerPage,
      'SellerInfo': instance.sellersDetail,
    };
