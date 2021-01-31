part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent extends Equatable {
  TransactionEvent([List props = const <dynamic>[]]) : super();
}

class SubmitTransaction extends TransactionEvent {
  final String privateKey;
  final String receiverAddress;
  final String amount;
  SubmitTransaction({@required this.privateKey, @required this.receiverAddress, @required this.amount}) : super([privateKey, receiverAddress, amount]);

  List<Object> get props => [{this.privateKey, this.receiverAddress, this.amount}];
}

class ResetHash extends TransactionEvent {

  List<Object> get props => [{}];
}
