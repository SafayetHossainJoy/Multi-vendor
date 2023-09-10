
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProductScreen/bloc/seller_Product_screen_state.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProductScreen/bloc/seller_product_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/sellerProductScreen/bloc/seller_product_screen_repository.dart';

class SellerProductScreenBloc
    extends Bloc<SellerProductScreenEvent, SellerProductScreenState> {
  SellerProductScreenRepositoryImp? repository;

  SellerProductScreenBloc({this.repository}) : super(SellerProductScreenInitialState()) {
    on<SellerProductScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      SellerProductScreenEvent event, Emitter<SellerProductScreenState> emit) async {
    if (event is SellerProductScreenDataFetchEvent) {
      emit(SellerProductScreenInitialState());
      try {
        var model = await repository?.getProductList(event.offset, event.limit, event.state, event.operator);
        if (model != null) {
          emit(SellerProductScreenSuccess(model));
        } else {
          emit(const SellerProductScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(SellerProductScreenError(error.toString()));
      }
    }
  }
}
