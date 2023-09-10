import 'package:equatable/equatable.dart';

abstract class AddReviewScreenEvent extends Equatable{
  const AddReviewScreenEvent();

  @override
  List<Object> get props => [];
}

class AddReviewEvert extends AddReviewScreenEvent{
  final int sellerId;
  final double rating;
final String title;
final String review;
const AddReviewEvert(this.sellerId,this.rating,this.title, this.review);
}