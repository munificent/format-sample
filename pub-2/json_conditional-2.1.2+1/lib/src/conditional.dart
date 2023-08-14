import 'package:json_class/json_class.dart';

import 'evaluation_mode.dart';

/// Conditionals can be used to evaluate a set of values and return a [bool]
/// based on the conditional criteria.
class Conditional extends JsonClass {
  /// Constructs the conditional.  The [mode] defaults to [EvaluationMode.and]
  /// and may not be `null`.
  ///
  /// Either [conditions] or [values] must be set, but not both.
  Conditional({
    this.conditions,
    this.mode = EvaluationMode.and,
    this.values,
  }) : assert(conditions == null || values == null),
       assert(conditions != null || values != null);

  /// The sub-conditions to evaluate as the criteria.
  final List<Conditional>? conditions;

  /// The mode to use when evaluating the criteria.
  final EvaluationMode mode;

  /// The key value pairs of values to evaluate against.
  final Map<String, dynamic>? values;

  /// Creates a new [Conditional] from a Map-like dynamic value.  The [map] must
  /// be a [Map] or a Map-like object that supports the `[String]` operator.
  ///
  /// If the [map] is `null` then this will return `null`.
  ///
  /// This expect the format of the object to be as follows:
  /// ```json
  /// {
  ///   "conditions": <Conditional[]>,
  ///   "mode": <String>,
  ///   "values": <Map<String, dynamic>>
  /// }
  /// ```
  ///
  /// Either [conditions] or [values] must be set, but not both.  The [mode]
  /// defaults to [EvaluationMode.and] if not set.
  ///
  /// See also:
  ///  * [EvaluationMode.fromCode]
  static Conditional? fromDynamic(dynamic map) {
    Conditional? result;

    if (map != null) {
      result = Conditional(
        conditions: fromDynamicList(map['conditions']),
        mode: EvaluationMode.fromCode(map['mode']) ?? EvaluationMode.and,
        values: map['values'] == null
            ? null
            : Map<String, dynamic>.from(map['values']),
      );
    }

    return result;
  }

  /// Creates a list of [Conditional] objects from a List-like dynamic [list].
  /// The list must be iterable or this will throw an error.
  ///
  /// If the [list] is `null` then this will return `null`.
  static List<Conditional>? fromDynamicList(Iterable<dynamic>? list) {
    List<Conditional>? results;

    if (list != null) {
      results = [];
      for (dynamic map in list) {
        results.add(fromDynamic(map)!);
      }
    }

    return results;
  }

  /// Evaluats the conditional to return a [bool] based on the criteria and the
  /// given values.  The given [values] must be a [Map] or a Map-like object
  /// that implements the `[]` operator or else an error will be thrown.
  ///
  /// This will either evaluate based off of the [values] or the child
  /// [conditional] objects.
  ///
  /// When operating in the [EvaluationMode.and] then all [values] must equal
  /// the respective values inside of [actual], or all the child conditionals
  /// must evaluate to [true].  When operating in [EvaluationMode.or] then only
  /// one of the [values] must exist in [actual] or only one of the
  /// [conditionals] must evaluate to [true].
  bool evaluate(dynamic actual) => values == null
      ? _evaluateConditions(actual ?? {})
      : _evaluateValues(actual ?? {});

  /// Encodes the inner representation of this model to a [json] compatible map.
  @override
  Map<String, dynamic> toJson() => JsonClass.removeNull({
    'conditions': JsonClass.toJsonList(conditions),
    'mode': mode.code,
    'values': values,
  });

  bool _evaluateConditions(dynamic actual) {
    assert(actual != null);

    var conditional = EvaluationMode.and == mode && actual?.isNotEmpty == true;

    for (var condition in conditions!) {
      final equal = condition.evaluate(actual);
      if (EvaluationMode.and == mode) {
        conditional = conditional && equal;
      } else {
        conditional = conditional || equal;
      }
    }

    return conditional;
  }

  bool _evaluateValues(dynamic actual) {
    assert(actual != null);

    var conditional = EvaluationMode.and == mode && actual?.isNotEmpty == true;

    for (var entry in values!.entries) {
      final equal =
          actual[entry.key]?.toString() == values![entry.key]?.toString();
      if (EvaluationMode.and == mode) {
        conditional = conditional && equal;
      } else {
        conditional = conditional || equal;
      }
    }

    return conditional;
  }
}
