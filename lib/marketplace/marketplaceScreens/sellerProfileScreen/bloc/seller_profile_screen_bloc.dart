
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProfileScreen/bloc/seller_profile_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProfileScreen/bloc/seller_profile_screen_repository.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProfileScreen/bloc/seller_profile_screen_state.dart';

class SellerProfileScreenBloc extends Bloc<SellerProfileScreenEvent, SellerProfileScreenState>{
  SellerProfileScreenRepositoryImp? repository;
  SellerProfileScreenBloc({this.repository}): super(SellerProfileInitialState()){
    on<SellerProfileScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      SellerProfileScreenEvent event, Emitter<SellerProfileScreenState> emit) async {
    if (event is SellerProfileScreenDataFetchEvent) {
      emit(SellerProfileInitialState());
      try {
        var model = await repository?.getSellerProfile(event.sellerId);
        if (model != null) {
          emit(SellerProfileScreenSuccessState(model));
        } else {
          emit(const SellerProfileScreenErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(SellerProfileScreenErrorState(error.toString()));
      }
    }
  }
}