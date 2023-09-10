import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/addReeviewScreen/bloc/add_review_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/addReeviewScreen/bloc/add_review_screen_repository.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/addReeviewScreen/bloc/add_review_screen_state.dart';

class AddReviewBloc extends Bloc<AddReviewScreenEvent, AddReviewScreenState>{
  AddReviewRepositoryImp? repository;
  AddReviewBloc({this.repository}) : super(InitialState()) {
    on<AddReviewScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      AddReviewScreenEvent event, Emitter<AddReviewScreenState> emit) async {
    if (event is AddReviewEvert) {
      emit(LoadingState());
      try {
        var model = await repository?.addSellerReview(event.sellerId,event.rating,
            event.title , event.review );
        if (model != null) {
          emit(SuccessState(model));
        } else {
          emit(const ErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ErrorState(error.toString()));
      }
    }
  }
}