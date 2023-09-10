
import 'package:floor/floor.dart';

@entity
class RecentProduct {
  @primaryKey
  String? templateId;
  String? name;
  String? image;
  String? priceUnit;
  String? priceReduce;

  RecentProduct({
    this.templateId,
    this.image,
    this.name,
    this.priceUnit,
    this.priceReduce
  });

  // factory RecentProduct.fromJson(Map<String, dynamic> json) {
  //   return RecentProduct(
  //     productId: json['productId'],
  //     name: json['name'],
  //     image: json['image'],
  //     price: json['price'],
  //   );
  // }

  @override
  String toString() {
    return "$templateId\n$name\n$priceUnit";
  }
}
