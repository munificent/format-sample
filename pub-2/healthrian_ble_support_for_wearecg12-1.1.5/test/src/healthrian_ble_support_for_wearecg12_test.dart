// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthrian_ble_support_for_wearecg12/'
    'healthrian_ble_support_for_wearecg12.dart';

void main() {
  group('HealthrianBleSupportForWearecg12', () {
    test('can be instantiated', () {
      WidgetsFlutterBinding.ensureInitialized();
      expect(BLEManager(), isNotNull);
    });
  });
}
