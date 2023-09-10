
import 'package:equatable/equatable.dart';

abstract class MarketplaceScreenEvent extends Equatable{
  const MarketplaceScreenEvent();
  @override
  List<Object> get props => [];
}

class MarketplaceScreenDataFetchEvent extends MarketplaceScreenEvent{
  const MarketplaceScreenDataFetchEvent();
}