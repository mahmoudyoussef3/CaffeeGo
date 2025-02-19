part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class PaymentLoading extends PaymentState {}
class PaymentSuccess extends PaymentState {
  final String message;
   PaymentSuccess({required this.message });
}
class PaymentError extends PaymentState {
  final String message;
   PaymentError({required this.message });
}

