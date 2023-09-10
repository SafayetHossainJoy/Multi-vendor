import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/marketplaceScreen/bloc/marketplace_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/marketplaceScreen/bloc/marketplace_screen_repository.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/marketplaceScreen/bloc/marketplace_screen_state.dart';

class MarketplaceScreenBloc extends Bloc<MarketplaceScreenEvent, MarketplaceScreenState>{
  MarketplaceScreenRepositoryImp? repository;
  MarketplaceScreenBloc({this.repository}): super(MarketplaceInitialState()){
    on<MarketplaceScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      MarketplaceScreenEvent event, Emitter<MarketplaceScreenState> emit) async {
    if (event is MarketplaceScreenDataFetchEvent) {
      emit(MarketplaceInitialState());
      try {
        var model = await repository?.getMarketplace();
        if (model != null) {
          emit(MarketplaceScreenSuccessState(model));
        } else {
          emit(const MarketplaceScreenErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(MarketplaceScreenErrorState(error.toString()));
      }
    }
  }
}