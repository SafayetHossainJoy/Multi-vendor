
import 'package:floor/floor.dart';

@entity
class RecentProduct {
  @primaryKey
  String? productId;
  String? name;
  String? image;
  String? price;

  RecentProduct({
    this.productId,
    this.image,
    this.name,
    this.price,
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
    return "$productId\n$name\n$price";
  }
}
