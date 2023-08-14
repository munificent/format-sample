//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

part of keyclic_sdk_api;

class Template {
  /// Returns a new [Template] instance.
  Template({
    this.body = const [],
    this.createdAt,
    this.footer = const [],
    this.header = const [],
    this.id,
    required this.name,
    required this.type,
    this.updatedAt,
  });

  /// Returns a new [Template] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static Template? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    DateTime? createdAt = json[r'createdAt'] is String
        ? DateTime.parse(json[r'createdAt'])
        : null;
    if (createdAt is DateTime && createdAt.isUtc == false) {
      createdAt = DateTime.parse('${json[r'createdAt']}Z');
    }

    DateTime? updatedAt = json[r'updatedAt'] is String
        ? DateTime.parse(json[r'updatedAt'])
        : null;
    if (updatedAt is DateTime && updatedAt.isUtc == false) {
      updatedAt = DateTime.parse('${json[r'updatedAt']}Z');
    }

    return Template(
      body: json[r'body'] is Iterable
          ? List<Map<String, dynamic>>.from(json[r'body'])
          : [],
      createdAt: createdAt,
      footer: json[r'footer'] is Iterable
          ? List<Map<String, dynamic>>.from(json[r'footer'])
          : [],
      header: json[r'header'] is Iterable
          ? List<Map<String, dynamic>>.from(json[r'header'])
          : [],
      id: json[r'id'],
      name: json[r'name'],
      type: json[r'type'],
      updatedAt: updatedAt,
    );
  }

  List<Map<String, dynamic>>? body;

  final DateTime? createdAt;

  List<Map<String, dynamic>>? footer;

  List<Map<String, dynamic>>? header;

  final String? id;

  String name;

  String type;

  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) {
    // Same reference
    if (identical(this, other)) {
      return true;
    }

    return other is Template &&
        DeepCollectionEquality.unordered().equals(body, other.body) &&
        other.createdAt == createdAt &&
        DeepCollectionEquality.unordered().equals(footer, other.footer) &&
        DeepCollectionEquality.unordered().equals(header, other.header) &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      (body == null ? 0 : body.hashCode) +
      (createdAt == null ? 0 : createdAt.hashCode) +
      (footer == null ? 0 : footer.hashCode) +
      (header == null ? 0 : header.hashCode) +
      (id == null ? 0 : id.hashCode) +
      name.hashCode +
      type.hashCode +
      (updatedAt == null ? 0 : updatedAt.hashCode);

  static List<Template> listFromJson(List<dynamic>? json) {
    if (json == null) {
      return <Template>[];
    }

    return json.fold(<Template>[], (List<Template> previousValue, element) {
      final Template? object = Template.fromJson(element);
      if (object is Template) {
        previousValue.add(object);
      }

      return previousValue;
    });
  }

  static Map<String, Template> mapFromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return <String, Template>{};
    }

    return json.entries.fold(
      <String, Template>{},
      (Map<String, Template> previousValue, element) {
        final Template? object = Template.fromJson(element.value);
        if (object is Template) {
          previousValue[element.key] = object;
        }

        return previousValue;
      },
    );
  }

  // maps a json object with a list of Template-objects as value to a dart map
  static Map<String, List<Template>> mapListFromJson(
    Map<String, dynamic>? json,
  ) {
    if (json == null) {
      return <String, List<Template>>{};
    }

    return json.map((key, value) {
      return MapEntry<String, List<Template>>(
        key,
        Template.listFromJson(value),
      );
    });
  }

  @override
  String toString() =>
      'Template[body=$body, createdAt=$createdAt, footer=$footer, header=$header, id=$id, name=$name, type=$type, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (body != null) r'body': body,
      if (createdAt != null) r'createdAt': createdAt!.toUtc().toIso8601String(),
      if (footer != null) r'footer': footer,
      if (header != null) r'header': header,
      if (id != null) r'id': id,
      r'name': name,
      r'type': type,
      if (updatedAt != null) r'updatedAt': updatedAt!.toUtc().toIso8601String(),
    };
  }
}
