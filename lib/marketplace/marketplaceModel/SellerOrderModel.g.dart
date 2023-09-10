// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SellerOrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerOrderModel _$SellerOrderModelFromJson(Map<String, dynamic> json) =>
    SellerOrderModel(
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
      totalCount: json['tcount'] as int?,
      itemsPerPage: json['itemsPerPage'] as int?,
      sellerOrder: (json['sellerOrderLines'] as List<dynamic>?)
          ?.map((e) => SellerOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$SellerOrderModelToJson(SellerOrderModel instance) =>
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
      'sellerOrderLines': instance.sellerOrder,
    };

SellerOrder _$SellerOrderFromJson(Map<String, dynamic> json) => SellerOrder(
      product: json['product'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      description: json['description'] as String?,
      orderStatus: json['order_state'] as String?,
      createDate: json['create_date'] as String?,
      customer: json['customer'] as String?,
      deliveredQty: (json['delivered_qty'] as num?)?.toDouble(),
      ineId: json['line_id'] as int?,
      marketplaceStatus: json['marketplace_state'] as String?,
      orderReference: json['order_reference'] as int?,
      priceUnit: json['priceUnit'] as String?,
      subTotal: json['sub_total'] as String?,
    );

Map<String, dynamic> _$SellerOrderToJson(SellerOrder instance) =>
    <String, dynamic>{
      'create_date': instance.createDate,
      'customer': instance.customer,
      'delivered_qty': instance.deliveredQty,
      'description': instance.description,
      'line_id': instance.ineId,
      'marketplace_state': instance.marketplaceStatus,
      'order_reference': instance.orderReference,
      'order_state': instance.orderStatus,
      'priceUnit': instance.priceUnit,
      'product': instance.product,
      'quantity': instance.quantity,
      'sub_total': instance.subTotal,
    };
