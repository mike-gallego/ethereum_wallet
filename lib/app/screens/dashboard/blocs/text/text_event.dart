part of 'text_bloc.dart';

@immutable
abstract class TextEvent extends Equatable {
   TextEvent([List props = const <dynamic>[]]) : super();

}

class ChangeText extends TextEvent {

  final String address, amount, message;

  ChangeText({@required this.address, this.amount, this.message}) : super([address, amount, message]);

  List<Object> get props => [{this.address, this.amount, this.message}];

}