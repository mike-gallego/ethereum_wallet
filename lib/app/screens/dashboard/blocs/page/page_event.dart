part of 'page_bloc.dart';

@immutable
abstract class PageEvent extends Equatable {
  PageEvent([List props = const <dynamic>[]]) : super();

}


class SwitchPage extends PageEvent {
  final String pageID;
  SwitchPage({@required this.pageID}) : super([pageID]);

  List<Object> get props => [{this.pageID}];
}