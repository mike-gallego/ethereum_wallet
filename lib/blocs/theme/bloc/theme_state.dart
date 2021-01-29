part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final bool isLight;
  ThemeState({this.isLight});

  List<Object> get props => [{this.isLight}];
}