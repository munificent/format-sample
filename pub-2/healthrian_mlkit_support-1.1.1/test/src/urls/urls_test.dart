import 'package:flutter_test/flutter_test.dart';
import 'package:healthrian_mlkit_support/healthrian_mlkit_support.dart';

void main() {
  test(
    'urls get v0 delineator',
    () {
      final url = Urls.getUrlString(
        apiVersions: ApiVersions.v0,
        applications: Applications.delineator,
      );
      expect(
        url,
        'http://112.222.235.52/mlkit/api/v0/delineator',
      );
    },
  );

  test(
    'urls get v0 delineator',
    () {
      final url = Urls.getUrlString(
        apiVersions: ApiVersions.v0,
        applications: Applications.analyzer,
      );
      expect(
        url,
        'http://112.222.235.52/mlkit/api/v0/analyze-ecg',
      );
    },
  );
}
