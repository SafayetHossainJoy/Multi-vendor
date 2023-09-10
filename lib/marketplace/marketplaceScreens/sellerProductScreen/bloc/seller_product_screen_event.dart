
import 'package:equatable/equatable.dart';

abstract class SellerProductScreenEvent extends Equatable{
  const SellerProductScreenEvent();

  @override
  List<Object> get props => [];
}

class SellerProductScreenDataFetchEvent extends SellerProductScreenEvent{
  final int offset;
  final int limit;
  final String state;
  final String operator;
  const SellerProductScreenDataFetchEvent(this.offset, this.limit, this.state, this.operator);
}