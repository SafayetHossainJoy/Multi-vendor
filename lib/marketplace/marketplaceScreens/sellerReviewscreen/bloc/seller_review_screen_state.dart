import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerReviewModel.dart';

abstract class SellerReviewScreenState extends Equatable{
  const SellerReviewScreenState();
  @override
  List<Object> get props => [];
}
class SellerReviewInitialState extends SellerReviewScreenState{}

class SellerReviewScreenSuccessState extends SellerReviewScreenState{
  final SellerReviewModel? data;
  const SellerReviewScreenSuccessState(this.data);
}

class SellerReviewScreenErrorState extends SellerReviewScreenState{
  final String message;
  const SellerReviewScreenErrorState(this.message);
}

class SellerLikeDislikeReviewState extends SellerReviewScreenState{
  final SellerReviewModel data;
  const SellerLikeDislikeReviewState(this.data);
}