
import 'package:equatable/equatable.dart';

abstract class SellerReviewScreenEvent extends Equatable{
  const SellerReviewScreenEvent();
  @override
  List<Object> get props => [];
}

class SellerReviewScreenDataFetchEvent extends SellerReviewScreenEvent{
  final int sellerId;
  const SellerReviewScreenDataFetchEvent(this.sellerId);
}
class SellerReviewLikeDislikeEvent extends SellerReviewScreenEvent{
final int reviewId;
final bool isHelpFul;
const SellerReviewLikeDislikeEvent(this.reviewId, this.isHelpFul);
}