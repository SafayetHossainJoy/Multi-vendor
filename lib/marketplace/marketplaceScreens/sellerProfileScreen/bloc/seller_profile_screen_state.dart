
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerProfileModel.dart';

abstract class SellerProfileScreenState extends Equatable{
  const SellerProfileScreenState();
  @override
  List<Object> get props => [];
}
class SellerProfileInitialState extends SellerProfileScreenState{}

class SellerProfileScreenSuccessState extends SellerProfileScreenState{
  final SellerProfileModel? data;
  const SellerProfileScreenSuccessState(this.data);
}

class SellerProfileScreenErrorState extends SellerProfileScreenState{
  final String message;
  const SellerProfileScreenErrorState(this.message);
}