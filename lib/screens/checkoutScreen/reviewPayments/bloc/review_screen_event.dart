import 'package:equatable/equatable.dart';

abstract class PaymentReviewScreenEvent extends Equatable{
  const PaymentReviewScreenEvent();

  @override
  List<Object> get props => [];
}

class GetPaymentMethodEvent extends PaymentReviewScreenEvent{

}

class OrderReviewEvent extends PaymentReviewScreenEvent{
 final int shippingAddressId;
 final int acquirerId;
 final int shippingId;

 const OrderReviewEvent(this.shippingAddressId,this.acquirerId,this.shippingId);

 @override
 List<Object> get props => [];
}

class PlaceOrderEvent extends PaymentReviewScreenEvent{
  final String paymentRefrence;
  final int transactionId;
  final String paymentStatus;
  final String token;
  final String stripeCustomerId;

  const PlaceOrderEvent(this.paymentRefrence,this.transactionId,this.paymentStatus, this.token, this.stripeCustomerId);

  @override
  List<Object> get props => [];
}