import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerDashboard/bloc/seller_dashboard_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerDashboard/bloc/seller_dashboard_screen_repository.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerDashboard/bloc/seller_dashboard_screen_state.dart';

class SellerDashboardScreenBloc extends Bloc<SellerDashboardScreenEvent, SellerDashboardScreenState>{
  SellerDashboardScreenRepositoryImp? repository;
  SellerDashboardScreenBloc({this.repository}): super(SellerDashboardInitialState()){
    on<SellerDashboardScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      SellerDashboardScreenEvent event, Emitter<SellerDashboardScreenState> emit) async {
    if (event is SellerDashboardScreenDataFetchEvent) {
      emit(SellerDashboardInitialState());
      try {
        var model = await repository?.getSellerDashboard();
        if (model != null) {
          emit(SellerDashboardScreenSuccessState(model));
        } else {
          emit(const SellerDashboardScreenErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(SellerDashboardScreenErrorState(error.toString()));
      }
    }
  }
}