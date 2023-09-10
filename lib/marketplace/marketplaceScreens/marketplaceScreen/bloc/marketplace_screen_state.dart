
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/MarketPlaceModel.dart';

abstract class MarketplaceScreenState extends Equatable{
  const MarketplaceScreenState();
  @override
  List<Object> get props => [];
}
class MarketplaceInitialState extends MarketplaceScreenState{}

class MarketplaceScreenSuccessState extends MarketplaceScreenState{
  final MarketPlaceModel? data;
  const MarketplaceScreenSuccessState(this.data);
}

class MarketplaceScreenErrorState extends MarketplaceScreenState{
  final String message;
  const MarketplaceScreenErrorState(this.message);
}