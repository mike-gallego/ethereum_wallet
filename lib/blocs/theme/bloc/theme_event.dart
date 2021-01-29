part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const <dynamic>[]]) : super();
}

class Toggle extends ThemeEvent {

  final bool isLight;

  Toggle({@required this.isLight}) : super([isLight]);

  List<Object> get props => [{this.isLight}];

}
