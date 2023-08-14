// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:json_class/json_class.dart';
import 'package:yaon/yaon.dart';

void main(List<String> args) {
  final files =
      Directory('schemas').listSync(recursive: true).whereType<File>().where(
            (e) => e.path.endsWith('.yaml') || e.path.endsWith('.json'),
          );
  const encoder = JsonEncoder.withIndent('  ');

  final schemas = <String, dynamic>{};
  File? dataSchema;

  final oneOf = <Map<String, dynamic>>[];
  oneOf.add({'type': 'string'});

  const child = {
    'oneOf': [
      {'type': 'string'},
      {
        r'$ref':
            'https://peiffer-innovations.github.io/flutter_json_schemas/schemas/json_dynamic_widget/json_widget_data.json',
      },
    ],
  };
  const children = {
    'oneOf': [
      {'type': 'string'},
      {
        'type': 'array',
        'items': {
          'oneOf': [
            {'type': 'string'},
            {
              r'$ref':
                  'https://peiffer-innovations.github.io/flutter_json_schemas/schemas/json_dynamic_widget/json_widget_data.json',
            },
          ],
        },
      },
    ],
  };

  const properties = <String, dynamic>{
    'id': {
      'type': 'string',
    },
    'listen': {
      'type': 'array',
      'items': {
        'type': 'string',
      }
    },
  };

  for (var file in files) {
    final data = file.readAsStringSync();

    final schema = yaon.parse(data);

    final id = schema[r'$id'].toString();
    final type = id.split('/').last;
    final children = JsonClass.parseInt(schema[r'$children']);
    if (id ==
        'https://peiffer-innovations.github.io/flutter_json_schemas/schemas/json_dynamic_widget/json_widget_data.json') {
      dataSchema = file;
    } else {
      if (children == null) {
        print('[OBJECT]: $type');
      } else {
        print('[WIDGET]: $type');
        schemas[id] = schema;
        oneOf.add(
          {
            'type': 'object',
            'additionalProperties': false,
            'properties': {
              ...properties,
              if (children == 1) 'child': child,
              if (children == -1) 'children': children,
              'properties': {
                'args': {
                  r'$ref': id,
                },
                'type': {
                  'type': 'string',
                  'const': type.substring(0, type.indexOf('.')),
                },
              },
            },
          },
        );
      }
    }
  }
  oneOf.add({
    'type': 'object',
    'additionalProperties': false,
    'required': ['type'],
    'properties': {
      ...properties,
      'args': {
        'type': 'object',
        'additionalProperties': true,
      },
      ...child,
      ...children,
    }
  });

  if (dataSchema == null) {
    print('Unable to locate the JsonWidgetData schema file');
    exit(1);
  }

  final output = File('output/json_dynamic_widget.json');
  if (output.existsSync()) {
    output.deleteSync(recursive: true);
  }
  output.createSync(recursive: true);
  output.writeAsStringSync(
    encoder.convert(
      {
        r'$schema': 'http://json-schema.org/draft-06/schema#',
        r'$id':
            'https://peiffer-innovations.github.io/flutter_json_schemas/schemas/json_dynamic_widget/json_widget_data.json',
        r'$comment':
            'https://pub.dev/documentation/json_dynamic_widget/latest/json_dynamic_widget/JsonWidgetData-class.html',
        'title': 'JsonWidgetData',
        'oneOf': oneOf
      },
    ),
  );
}
