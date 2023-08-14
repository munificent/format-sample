import 'dart:async';

import 'package:easy_mq_core/src/broker.dart';

Future<void> main() async {
  Broker.newBroker(9090);
  await Future.delayed(Duration(minutes: 60));
}
