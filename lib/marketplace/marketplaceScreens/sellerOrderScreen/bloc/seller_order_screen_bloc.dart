
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerOrderScreen/bloc/seller_order_screen_state.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerOrderScreen/bloc/seller_order_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerOrderScreen/bloc/seller_order_screen_repository.dart';

class SellerOrderScreenBloc
    extends Bloc<SellerOrderScreenEvent, SellerOrderScreenState> {
  SellerOrderScreenRepositoryImp? repository;

  SellerOrderScreenBloc({this.repository}) : super(SellerOrderScreenInitialState()) {
    on<SellerOrderScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      SellerOrderScreenEvent event, Emitter<SellerOrderScreenState> emit) async {
    if (event is SellerOrderScreenDataFetchEvent) {
      emit(SellerOrderScreenInitialState());
      try {
        var model = await repository?.getOrderList(event.offset, event.limit, event.state);
        if (model != null) {
          emit(SellerOrderScreenSuccess(model));
        } else {
          emit(const SellerOrderScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(SellerOrderScreenError(error.toString()));
      }
    }
  }
}
