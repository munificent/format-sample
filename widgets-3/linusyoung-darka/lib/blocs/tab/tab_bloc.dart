import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darka/blocs/tab/tab_event.dart';
import 'package:darka/model/app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.tasks;

  @override
  Stream<AppTab> mapEventToState(
    event,
  ) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
