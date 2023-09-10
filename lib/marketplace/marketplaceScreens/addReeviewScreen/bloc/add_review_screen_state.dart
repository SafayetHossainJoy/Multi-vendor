
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';

abstract class AddReviewScreenState extends Equatable{
  const AddReviewScreenState();

  @override
  List<Object> get props => [];
}

class InitialState extends AddReviewScreenState{

}

class LoadingState extends AddReviewScreenState{}

class SuccessState extends AddReviewScreenState{
  final BaseModel data;
  const SuccessState(this.data);
}

class ErrorState extends AddReviewScreenState{
  final String message;
  const ErrorState(this.message);
}