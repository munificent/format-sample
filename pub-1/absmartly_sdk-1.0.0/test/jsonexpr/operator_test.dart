import 'package:absmartly_sdk/jsonexpr/json_expr.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("operators", () {
    test('evaluateExpr() test equals operator', () {
      final expr = {
        'eq': [
          {"var": "age"},
          {"value": 20}
        ],
      };
      var vars = {'age': 20};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(true));

      vars = {'age': 42};

      result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(false));
    });

    test('evaluateExpr() test and operator', () {
      final expr = {
        'and': [
          {"var": "age"},
          {"value": 1}
        ],
      };
      var vars = {'age': 1};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(true));

      vars = {'age': 0};

      result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(false));
    });

    test('evaluateExpr() test or operator', () {
      final expr = {
        'or': [
          {"var": "age"},
          {"value": 0}
        ],
      };
      var vars = {'age': 1};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(true));

      vars = {'age': 0};

      result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(false));
    });
    test('evaluateExpr() test greater than operator', () {
      final expr = {
        'gt': [
          {"var": "age"},
          {"value": 22}
        ],
      };
      var vars = {'age': 23};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(true));

      vars = {'age': 22};

      result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(false));
    });
    test('evaluateExpr() test greater than equal to operator', () {
      final expr = {
        'gte': [
          {"var": "age"},
          {"value": 22}
        ],
      };
      var vars = {'age': 22};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(true));

      vars = {'age': 21};

      result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(false));
    });
    test('evaluateExpr() test less than operator', () {
      final expr = {
        'lt': [
          {"var": "age"},
          {"value": 22}
        ],
      };
      var vars = {'age': 21};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(true));

      vars = {'age': 23};

      result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(false));
    });
    test('evaluateExpr() test less than equal to operator', () {
      final expr = {
        'lte': [
          {"var": "age"},
          {"value": 22}
        ],
      };
      var vars = {'age': 22};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(true));

      vars = {'age': 23};

      result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(false));
    });
    test('evaluateExpr() test not operator', () {
      final expr = {
        'not': [
          {"var": "age"},
          {"value": 1}
        ],
      };
      var vars = {'age': 0};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(true));

      vars = {'age': 1};

      result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(false));
    });


    test('evaluateExpr() test in operator', () {
      final expr = {
        'in': [
          {"var": "value"},
          {"value": "am"}
        ],
      };
      Map<String, dynamic> vars = {'value': "Hamza"};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(true));


      vars = {"value" : {"am" : "name"}};
      result = JsonExpr().evaluateExpr(expr, vars);

      expect(result, equals(true));
    });


    test('evaluateExpr() test null operator', () {
      final expr = {
        'null': null,
      };
      var vars = {'age': null};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(true));
    });


    test('evaluateExpr() test match operator', () {
      final expr = {
        'match': [
          {"var": "email"},
          {"value": "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}\b"}
        ],
      };
      var vars = {'email': "test@test.com"};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(false));
    });




    test('evaluateExpr() test value operator', () {
      final expr = {
        'null': [
          {"var": "age"},
          {"value": null}
        ],
      };
      var vars = {'age': 1};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(false));
    });


    test('evaluateExpr() test var operator', () {
      final expr = {
        'var': {
          "path" : "path"
        },
      };
      var vars = {'path': true};
      var result = JsonExpr().evaluateExpr(expr, vars);
      expect(result, equals(true));
    });

  });
}
