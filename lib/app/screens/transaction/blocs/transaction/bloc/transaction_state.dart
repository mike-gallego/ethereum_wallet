part of 'transaction_bloc.dart';

class TransactionState extends Equatable {
  final String senderAddress;
  final String receiverAddress;
  final String amount;
  final String transactionHash;
  final BuildContext context;

  TransactionState({this.senderAddress, this.receiverAddress, this.amount, this.transactionHash, this.context});
  
  List<Object> get props => [{this.senderAddress, this.receiverAddress, this.amount, this.transactionHash, this.context}];
}
