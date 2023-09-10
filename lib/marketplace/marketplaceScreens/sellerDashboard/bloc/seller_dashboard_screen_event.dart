import 'package:equatable/equatable.dart';

abstract class SellerDashboardScreenEvent extends Equatable{
  const SellerDashboardScreenEvent();
  @override
  List<Object> get props => [];
}

class SellerDashboardScreenDataFetchEvent extends SellerDashboardScreenEvent{
  const SellerDashboardScreenDataFetchEvent();
}