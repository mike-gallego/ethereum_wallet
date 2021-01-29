part of 'hide_bloc.dart';

class HideState extends Equatable {
  final bool isBlur;
  HideState({this.isBlur});
  
  List<Object> get props => [{this.isBlur}];
}
