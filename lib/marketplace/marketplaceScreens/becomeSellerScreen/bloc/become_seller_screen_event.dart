
import 'package:equatable/equatable.dart';

abstract class BecomeSellerScreenEvent extends Equatable {
  const BecomeSellerScreenEvent();

  @override
  List<Object> get props => [];
}

class BecomeSellerScreenInitialEvent extends BecomeSellerScreenEvent {
  const BecomeSellerScreenInitialEvent();
}

class BecomeSellerSaveDetailsEvent extends BecomeSellerScreenEvent {
  final int countryId;
  final String profile;

  const BecomeSellerSaveDetailsEvent(this.countryId, this.profile);
}

class BecomeSellerTermsEvent extends BecomeSellerScreenEvent{}
