
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerOrderModel.dart';

abstract class SellerOrderScreenState extends Equatable {
  const SellerOrderScreenState();

  @override
  List<Object> get props => [];
}

class SellerOrderScreenInitialState extends SellerOrderScreenState{}

class SellerOrderScreenSuccess extends SellerOrderScreenState{
  final SellerOrderModel orders;
  const SellerOrderScreenSuccess(this.orders);
}

class SellerOrderScreenError extends SellerOrderScreenState{
  final String message;
  const SellerOrderScreenError(this.message);
}
