// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MarketPlaceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketPlaceModel _$MarketPlaceModelFromJson(Map<String, dynamic> json) =>
    MarketPlaceModel(
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
      ..banner = json['banner'] as String?
      ..heading = json['heading'] as String?
      ..wishlist = json['wishlist'] as List<dynamic>?
      ..sellersDetail = (json['SellersDetail'] as List<dynamic>?)
          ?.map((e) => SellersDetail.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MarketPlaceModelToJson(MarketPlaceModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'addons': instance.addons,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'banner': instance.banner,
      'heading': instance.heading,
      'wishlist': instance.wishlist,
      'WishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'seller_group': instance.sellerGroup,
      'seller_state': instance.sellerState,
      'itemsPerPage': instance.itemsPerPage,
      'SellersDetail': instance.sellersDetail,
    };

SellersDetail _$SellersDetailFromJson(Map<String, dynamic> json) =>
    SellersDetail(
      email: json['email'] as String?,
      createDate: json['create_date'] as String?,
      name: json['name'] as String?,
      sellerProducts: json['sellerProducts'] == null
          ? null
          : SellerProducts.fromJson(
              json['sellerProducts'] as Map<String, dynamic>),
      state: json['state'] as String?,
      country: json['country'] as String?,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      mobile: json['mobile'] as String?,
      phone: json['phone'] as String?,
      productCount: json['product_count'] as int?,
      productMessage: json['product_msg'] as String?,
      returnPolicy: json['return_policy'] as String?,
      salesCount: (json['sales_count'] as num?)?.toDouble(),
      sellerId: json['seller_id'] as int?,
      sellerProfileBanner: json['seller_profile_banner'] as String?,
      sellerProfileImage: json['seller_profile_image'] as String?,
      sellerReviews: (json['seller_reviews'] as List<dynamic>?)
          ?.map((e) => SellerReviews.fromJson(e as Map<String, dynamic>))
          .toList(),
      shippingPolicy: json['shipping_policy'] as String?,
      totalReviews: json['total_reviews'] as int?,
    );

Map<String, dynamic> _$SellersDetailToJson(SellersDetail instance) =>
    <String, dynamic>{
      'average_rating': instance.averageRating,
      'country': instance.country,
      'create_date': instance.createDate,
      'email': instance.email,
      'mobile': instance.mobile,
      'name': instance.name,
      'phone': instance.phone,
      'product_count': instance.productCount,
      'product_msg': instance.productMessage,
      'return_policy': instance.returnPolicy,
      'sales_count': instance.salesCount,
      'seller_id': instance.sellerId,
      'seller_profile_banner': instance.sellerProfileBanner,
      'seller_profile_image': instance.sellerProfileImage,
      'seller_reviews': instance.sellerReviews,
      'shipping_policy': instance.shippingPolicy,
      'total_reviews': instance.totalReviews,
      'state': instance.state,
      'sellerProducts': instance.sellerProducts,
    };

SellerReviews _$SellerReviewsFromJson(Map<String, dynamic> json) =>
    SellerReviews(
      name: json['name'] as String?,
      title: json['title'] as String?,
      createDate: json['create_date'] as String?,
      id: json['id'] as int?,
      image: json['image'] as String?,
      rating: json['rating'] as int?,
      displayName: json['display_name'] as String?,
      email: json['email'],
      helpful: json['helpful'] as int?,
      messageIsFollower: json['message_is_follower'] as bool?,
      msg: json['msg'] as String?,
      notHelpful: json['not_helpful'] as int?,
      totalVote: json['total_votes'] as int?,
    );

Map<String, dynamic> _$SellerReviewsToJson(SellerReviews instance) =>
    <String, dynamic>{
      'create_date': instance.createDate,
      'display_name': instance.displayName,
      'email': instance.email,
      'helpful': instance.helpful,
      'id': instance.id,
      'image': instance.image,
      'message_is_follower': instance.messageIsFollower,
      'msg': instance.msg,
      'name': instance.name,
      'not_helpful': instance.notHelpful,
      'rating': instance.rating,
      'title': instance.title,
      'total_votes': instance.totalVote,
    };

SellerProducts _$SellerProductsFromJson(Map<String, dynamic> json) =>
    SellerProducts(
      totalCount: json['tcount'] as int?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
      offset: json['offset'] as int?,
    );

Map<String, dynamic> _$SellerProductsToJson(SellerProducts instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'tcount': instance.totalCount,
      'products': instance.products,
    };
