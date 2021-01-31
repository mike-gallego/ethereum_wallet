import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc(PageState pageState) : super(pageState);

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is SwitchPage) {
      yield PageState(pageID: event.pageID);
    }
  }
}
