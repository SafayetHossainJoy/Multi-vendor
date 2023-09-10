import 'package:equatable/equatable.dart';

abstract class SellerOrderScreenEvent extends Equatable{
  const SellerOrderScreenEvent();

  @override
  List<Object> get props => [];
}

class SellerOrderScreenDataFetchEvent extends SellerOrderScreenEvent{
  final int offset;
  final int limit;
  final String state;
  const SellerOrderScreenDataFetchEvent(this.offset, this.limit, this.state);
}