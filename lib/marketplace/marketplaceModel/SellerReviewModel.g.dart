// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SellerReviewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerReviewModel _$SellerReviewModelFromJson(Map<String, dynamic> json) =>
    SellerReviewModel(
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
      sellerReview: (json['SellerReview'] as List<dynamic>?)
          ?.map((e) => SellerReviews.fromJson(e as Map<String, dynamic>))
          .toList(),
      sellerProfileImage: json['seller_profile_image'] as String?,
      sellerImage: json['seller_image'] as String?,
      sellerReviewCount: json['sellerReviewCount'] as int?,
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$SellerReviewModelToJson(SellerReviewModel instance) =>
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
      'SellerReview': instance.sellerReview,
      'sellerReviewCount': instance.sellerReviewCount,
      'seller_image': instance.sellerImage,
      'seller_profile_image': instance.sellerProfileImage,
    };
