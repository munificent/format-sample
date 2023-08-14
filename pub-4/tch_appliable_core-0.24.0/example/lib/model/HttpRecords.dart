import 'package:example/model/HttpRecord.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

class HttpRecords extends DataModel {
  static const String METHOD = '/Person';

  late List<HttpRecord> records;

  /// HttpRecords initialization from JSON map
  HttpRecords.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    final List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(json['list']);

    records = list.map((Map<String, dynamic> item) => HttpRecord.fromJson(item)).toList();
  }

  /// Covert the object into JSON map
  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'list': records.map((HttpRecord record) => record.toJson()).toList(),
    };

    return json;
  }
}
