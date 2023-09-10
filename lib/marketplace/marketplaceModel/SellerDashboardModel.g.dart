// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SellerDashboardModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerDashboardModel _$SellerDashboardModelFromJson(
        Map<String, dynamic> json) =>
    SellerDashboardModel(
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
      sellerDashboard: json['sellerDashboard'] == null
          ? null
          : SellerDashboard.fromJson(
              json['sellerDashboard'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$SellerDashboardModelToJson(
        SellerDashboardModel instance) =>
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
      'sellerDashboard': instance.sellerDashboard,
    };

SellerDashboard _$SellerDashboardFromJson(Map<String, dynamic> json) =>
    SellerDashboard(
      total: json['total'] == null
          ? null
          : Total.fromJson(json['total'] as Map<String, dynamic>),
      approvedOrderCount: json['approved_solCount'] as int?,
      approvedProductCount: json['approved_productCount'] as int?,
      balance: json['balance'] == null
          ? null
          : Total.fromJson(json['balance'] as Map<String, dynamic>),
      newOrderCount: json['new_solCount'] as int?,
      pendingProductCount: json['pending_productCount'] as int?,
      rejectedProductCount: json['rejected_productCount'] as int?,
      shippedOrderCount: json['shipped_solCount'] as int?,
    );

Map<String, dynamic> _$SellerDashboardToJson(SellerDashboard instance) =>
    <String, dynamic>{
      'approved_productCount': instance.approvedProductCount,
      'approved_solCount': instance.approvedOrderCount,
      'new_solCount': instance.newOrderCount,
      'pending_productCount': instance.pendingProductCount,
      'rejected_productCount': instance.rejectedProductCount,
      'shipped_solCount': instance.shippedOrderCount,
      'total': instance.total,
      'balance': instance.balance,
    };

Total _$TotalFromJson(Map<String, dynamic> json) => Total(
      value: (json['value'] as num?)?.toDouble(),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$TotalToJson(Total instance) => <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };
