part of 'text_bloc.dart';

class TextState extends Equatable {
  final String address, amount, message;
  TextState({this.address, this.amount, this.message});
  
  List<Object> get props => [{this.address, this.amount, this.message}];
}

