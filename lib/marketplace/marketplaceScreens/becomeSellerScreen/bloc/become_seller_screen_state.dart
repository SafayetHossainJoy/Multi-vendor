import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/models/SignUpTermsModel.dart';

abstract class BecomeSellerScreenState extends Equatable{
  const BecomeSellerScreenState();
  @override
  List<Object> get props => [];
}
class BecomeSellerInitialState extends BecomeSellerScreenState{}

class BecomeSellerScreenSuccessState extends BecomeSellerScreenState{
  final CountryListModel? data;
  const BecomeSellerScreenSuccessState(this.data);
}

class BecomeSellerScreenErrorState extends BecomeSellerScreenState{
  final String message;
  const BecomeSellerScreenErrorState(this.message);
}

class BecomeSellerDetailsSuccessState extends BecomeSellerScreenState{
  final BaseModel data;
  const BecomeSellerDetailsSuccessState(this.data);
}

class BecomeSellerTermSuccessState extends BecomeSellerScreenState{
  final SignUpTermsModel data;
  const BecomeSellerTermSuccessState(this.data);
}
