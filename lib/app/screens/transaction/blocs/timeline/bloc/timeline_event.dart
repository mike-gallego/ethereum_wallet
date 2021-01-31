part of 'timeline_bloc.dart';

@immutable
abstract class TimelineEvent extends Equatable {
  TimelineEvent([List props = const <dynamic>[]]) : super();

}

class NextStep extends TimelineEvent {
  final int index;
  NextStep({@required this.index}) : super([index]);

  List<Object> get props => [{this.index}];
}

