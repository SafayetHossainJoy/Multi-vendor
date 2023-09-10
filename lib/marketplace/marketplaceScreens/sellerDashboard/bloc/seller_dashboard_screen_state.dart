
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerDashboardModel.dart';

abstract class SellerDashboardScreenState extends Equatable{
  const SellerDashboardScreenState();
  @override
  List<Object> get props => [];
}
class SellerDashboardInitialState extends SellerDashboardScreenState{}

class SellerDashboardScreenSuccessState extends SellerDashboardScreenState{
  final SellerDashboardModel? data;
  const SellerDashboardScreenSuccessState(this.data);
}

class SellerDashboardScreenErrorState extends SellerDashboardScreenState{
  final String message;
  const SellerDashboardScreenErrorState(this.message);
}