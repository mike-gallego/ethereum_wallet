import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'hide_event.dart';
part 'hide_state.dart';

class HideBloc extends Bloc<HideEvent, HideState> {
  HideBloc(HideState hideState) : super(hideState);

  @override
  HideState get initialState => HideState(isBlur: state.isBlur);

  @override
  Stream<HideState> mapEventToState(
    HideEvent event,
  ) async* {
    if (event is ShowPrivateKey) {
      yield HideState(isBlur: !state.isBlur);
    }
  }
}
