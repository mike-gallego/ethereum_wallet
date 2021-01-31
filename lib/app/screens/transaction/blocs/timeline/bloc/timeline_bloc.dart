import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'timeline_event.dart';
part 'timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(TimelineState timelineState) : super(timelineState);

  @override
  Stream<TimelineState> mapEventToState(
    TimelineEvent event,
  ) async* {
    if (event is NextStep) {
      yield TimelineState(index: event.index);
    }
  }
}
