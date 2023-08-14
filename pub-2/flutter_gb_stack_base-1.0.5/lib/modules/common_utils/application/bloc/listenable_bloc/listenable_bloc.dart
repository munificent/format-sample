// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class ListenableBloc<Event, State> extends Bloc<Event, State> {
  final Logger? logger;
  final bool logEvents;
  final bool Function(Event event)? logFilter;
  final String Function(Event event)? customLogOutput;

  ListenableBloc(
    State initialState, {
    this.logger,
    this.logEvents = false,
    this.logFilter,
    this.customLogOutput,
  }) : super(initialState);

  final StreamController<Event> _eventStreamController =
      StreamController.broadcast();

  @override
  @mustCallSuper
  Future<void> close() async {
    _eventStreamController.close();
    return super.close();
  }

  @override
  @protected
  @mustCallSuper
  void onEvent(Event event) {
    super.onEvent(event);
    if (logEvents && (logFilter?.call(event) ?? true)) {
      logger?.v(
        customLogOutput?.call(event) ?? event,
      );
    }
    if (!_eventStreamController.isClosed) {
      _eventStreamController.add(event);
    }
  }

  Stream<Event> events() {
    return _eventStreamController.stream;
  }
}
