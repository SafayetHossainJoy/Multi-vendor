
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerProductModel.dart';

abstract class SellerProductScreenState extends Equatable {
  const SellerProductScreenState();

  @override
  List<Object> get props => [];
}

class SellerProductScreenInitialState extends SellerProductScreenState{}

class SellerProductScreenSuccess extends SellerProductScreenState{
  final SellerProductModel products;
  const SellerProductScreenSuccess(this.products);
}

class SellerProductScreenError extends SellerProductScreenState{
  final String message;
  const SellerProductScreenError(this.message);
}
