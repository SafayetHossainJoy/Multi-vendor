
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/SellerReviewscreen/bloc/seller_review_screen_event.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/SellerReviewscreen/bloc/seller_review_screen_repository.dart';
import 'package:flutter_project_structure/marketplace/marketplaceScreens/SellerReviewscreen/bloc/seller_review_screen_state.dart';

class SellerReviewScreenBloc extends Bloc<SellerReviewScreenEvent, SellerReviewScreenState>{
  SellerReviewScreenRepositoryImp? repository;
  SellerReviewScreenBloc({this.repository}): super(SellerReviewInitialState()){
    on<SellerReviewScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      SellerReviewScreenEvent event, Emitter<SellerReviewScreenState> emit) async {
    if (event is SellerReviewScreenDataFetchEvent) {
      emit(SellerReviewInitialState());
      try {
        var model = await repository?.getSellerReview(event.sellerId);
        if (model != null) {
          emit(SellerReviewScreenSuccessState(model));
        } else {
          emit(const SellerReviewScreenErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(SellerReviewScreenErrorState(error.toString()));
      }
    }
    else if(event is SellerReviewLikeDislikeEvent){
      emit(SellerReviewInitialState());
      try {
        var model = await repository?.likeDislikeReview(event.reviewId, event.isHelpFul);
        if (model != null) {
          emit(SellerLikeDislikeReviewState(model));
        } else {
          emit(const SellerReviewScreenErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(SellerReviewScreenErrorState(error.toString()));
      }
    }
  }
}