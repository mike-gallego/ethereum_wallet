part of 'page_bloc.dart';

class PageState extends Equatable {
  final String pageID;
  PageState({this.pageID});
  
  List<Object> get props => [{this.pageID}];
}
