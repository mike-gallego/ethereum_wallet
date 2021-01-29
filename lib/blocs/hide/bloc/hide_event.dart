part of 'hide_bloc.dart';

@immutable
abstract class HideEvent extends Equatable {
  HideEvent([List props = const <dynamic>[]]) : super();
}


class ShowPrivateKey extends HideEvent {

  final bool isBlur;

  ShowPrivateKey({@required this.isBlur}) : super([isBlur]);

  List<Object> get props => [{this.isBlur}];

}
