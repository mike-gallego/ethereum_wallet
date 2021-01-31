import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'text_event.dart';
part 'text_state.dart';

class TextBloc extends Bloc<TextEvent, TextState> {
  TextBloc(TextState textState) : super(textState);

  @override
  Stream<TextState> mapEventToState(
    TextEvent event,
  ) async* {
    if (event is ChangeText) {
      yield TextState(address: event.address, amount: event.amount, message: event.message);
    }
  }
}
