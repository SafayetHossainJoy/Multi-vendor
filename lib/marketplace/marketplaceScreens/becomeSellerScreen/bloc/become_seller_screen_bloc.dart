
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/becomeSellerScreen/bloc/become_seller_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/becomeSellerScreen/bloc/become_seller_screen_repository.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/becomeSellerScreen/bloc/become_seller_screen_state.dart';

class BecomeSellerScreenBloc extends Bloc<BecomeSellerScreenEvent, BecomeSellerScreenState>{
  BecomeSellerScreenRepositoryImp? repository;
  BecomeSellerScreenBloc({this.repository}): super(BecomeSellerInitialState()){
    on<BecomeSellerScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      BecomeSellerScreenEvent event, Emitter<BecomeSellerScreenState> emit) async {
    if (event is BecomeSellerScreenInitialEvent) {
      emit(BecomeSellerInitialState());
      try {
        var model = await repository?.getCountryList();
        if (model != null) {
          emit(BecomeSellerScreenSuccessState(model));
        } else {
          emit(const BecomeSellerScreenErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(BecomeSellerScreenErrorState(error.toString()));
      }
    }
    else if(event is BecomeSellerSaveDetailsEvent){
      emit(BecomeSellerInitialState());
      try {
        var model = await repository?.registerSeller(event.countryId, event.profile);
        if (model != null) {
          emit(BecomeSellerDetailsSuccessState(model));
        } else {
          emit(const BecomeSellerScreenErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(BecomeSellerScreenErrorState(error.toString()));
      }
    }
    else if(event is BecomeSellerTermsEvent){
      emit(BecomeSellerInitialState());
      try{
        var model = await repository?.getSellerTerms();
        if (model != null) {
          emit(BecomeSellerTermSuccessState(model));
        } else {
          emit(const BecomeSellerScreenErrorState(''));
        }
      }
      catch(error){
        print(error.toString());
        emit(BecomeSellerScreenErrorState(error.toString()));
      }
    }
  }
}