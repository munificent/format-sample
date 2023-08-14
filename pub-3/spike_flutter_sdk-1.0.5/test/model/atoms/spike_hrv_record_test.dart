import 'package:flutter_test/flutter_test.dart';
import 'package:spike_flutter_sdk/model/atoms/spike_hrv_record.dart';

void main() {
  test('deserialization is correct (case 1)', () {
    // Arrange
    const object = {"day_hrv": 77.1, "sleep_hrv": 89};

    // Act
    final result = SpikeHRVRecord.fromObject(object);

    // Assert
    expect(result.dayHRV, 77.1);
    expect(result.sleepHRV, 89);
  });

  test('deserialization is correct (case 2)', () {
    // Arrange
    const object = {};

    // Act
    final result = SpikeHRVRecord.fromObject(object);

    // Assert
    expect(result.dayHRV, null);
    expect(result.sleepHRV, null);
  });
}
