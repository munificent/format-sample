import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {
  MockClient() {
    when(post(Uri.parse('https://example.com/check'), body: anyNamed('body')))
        .thenAnswer((answering) {
      dynamic body = answering.namedArguments[const Symbol('body')];

      if (body != null && body is String) {
        var decodedJson = json.decode(body) as Map<String, String>;

        if (decodedJson['phone_number'] == '+447930654537') {
          return Future.value(http.Response('', 200));
        }
      }

      return Future.value(http.Response('', 401));
    });

    when(post(Uri.parse('https://example.com/check_status?check_id=92039d9sjf20dlsld9')))
        .thenAnswer((_) => Future.value(http.Response('', 401)));
  }
}