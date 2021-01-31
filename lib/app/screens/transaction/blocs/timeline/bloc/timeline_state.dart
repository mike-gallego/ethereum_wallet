part of 'timeline_bloc.dart';

class TimelineState extends Equatable {
  final int index;
  TimelineState({this.index});
  
  List<Object> get props => [{this.index}];
}

