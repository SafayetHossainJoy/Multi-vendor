
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/AskToAdminModel.dart';

abstract class AskToAdminScreenState extends Equatable{
  const AskToAdminScreenState();

  @override
  List<Object> get props => [];
}

class InitialState extends AskToAdminScreenState{

}

class LoadingState extends AskToAdminScreenState{}

class SuccessState extends AskToAdminScreenState{
  final AskToAdminModel data;
  const SuccessState(this.data);
}

class ErrorState extends AskToAdminScreenState{
  final String message;
  const ErrorState(this.message);
}