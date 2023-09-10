

import 'package:equatable/equatable.dart';

abstract class SellerProfileScreenEvent extends Equatable{
  const SellerProfileScreenEvent();
  @override
  List<Object> get props => [];
}

class SellerProfileScreenDataFetchEvent extends SellerProfileScreenEvent{
  final int sellerId;
  const SellerProfileScreenDataFetchEvent(this.sellerId);
}