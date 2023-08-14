// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gmaps_auto_complete_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GmapsAutoCompleteResponse _$GmapsAutoCompleteResponseFromJson(
    Map<String, dynamic> json) {
  return _GmapsAutoCompleteResponse.fromJson(json);
}

/// @nodoc
mixin _$GmapsAutoCompleteResponse {
  List<GmapsPrediction> get predictions => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GmapsAutoCompleteResponseCopyWith<GmapsAutoCompleteResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GmapsAutoCompleteResponseCopyWith<$Res> {
  factory $GmapsAutoCompleteResponseCopyWith(GmapsAutoCompleteResponse value,
          $Res Function(GmapsAutoCompleteResponse) then) =
      _$GmapsAutoCompleteResponseCopyWithImpl<$Res, GmapsAutoCompleteResponse>;
  @useResult
  $Res call({List<GmapsPrediction> predictions, String status});
}

/// @nodoc
class _$GmapsAutoCompleteResponseCopyWithImpl<$Res,
        $Val extends GmapsAutoCompleteResponse>
    implements $GmapsAutoCompleteResponseCopyWith<$Res> {
  _$GmapsAutoCompleteResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictions = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      predictions: null == predictions
          ? _value.predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as List<GmapsPrediction>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GmapsAutoCompleteResponseCopyWith<$Res>
    implements $GmapsAutoCompleteResponseCopyWith<$Res> {
  factory _$$_GmapsAutoCompleteResponseCopyWith(
          _$_GmapsAutoCompleteResponse value,
          $Res Function(_$_GmapsAutoCompleteResponse) then) =
      __$$_GmapsAutoCompleteResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GmapsPrediction> predictions, String status});
}

/// @nodoc
class __$$_GmapsAutoCompleteResponseCopyWithImpl<$Res>
    extends _$GmapsAutoCompleteResponseCopyWithImpl<$Res,
        _$_GmapsAutoCompleteResponse>
    implements _$$_GmapsAutoCompleteResponseCopyWith<$Res> {
  __$$_GmapsAutoCompleteResponseCopyWithImpl(
      _$_GmapsAutoCompleteResponse _value,
      $Res Function(_$_GmapsAutoCompleteResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictions = null,
    Object? status = null,
  }) {
    return _then(_$_GmapsAutoCompleteResponse(
      predictions: null == predictions
          ? _value.predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as List<GmapsPrediction>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GmapsAutoCompleteResponse implements _GmapsAutoCompleteResponse {
  const _$_GmapsAutoCompleteResponse(
      {required this.predictions, required this.status});

  factory _$_GmapsAutoCompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$$_GmapsAutoCompleteResponseFromJson(json);

  @override
  final List<GmapsPrediction> predictions;
  @override
  final String status;

  @override
  String toString() {
    return 'GmapsAutoCompleteResponse(predictions: $predictions, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GmapsAutoCompleteResponse &&
            const DeepCollectionEquality()
                .equals(other.predictions, predictions) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(predictions), status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GmapsAutoCompleteResponseCopyWith<_$_GmapsAutoCompleteResponse>
      get copyWith => __$$_GmapsAutoCompleteResponseCopyWithImpl<
          _$_GmapsAutoCompleteResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GmapsAutoCompleteResponseToJson(
      this,
    );
  }
}

abstract class _GmapsAutoCompleteResponse implements GmapsAutoCompleteResponse {
  const factory _GmapsAutoCompleteResponse(
      {required final List<GmapsPrediction> predictions,
      required final String status}) = _$_GmapsAutoCompleteResponse;

  factory _GmapsAutoCompleteResponse.fromJson(Map<String, dynamic> json) =
      _$_GmapsAutoCompleteResponse.fromJson;

  @override
  List<GmapsPrediction> get predictions;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$_GmapsAutoCompleteResponseCopyWith<_$_GmapsAutoCompleteResponse>
      get copyWith => throw _privateConstructorUsedError;
}

GmapsPrediction _$GmapsPredictionFromJson(Map<String, dynamic> json) {
  return _GmapsPrediction.fromJson(json);
}

/// @nodoc
mixin _$GmapsPrediction {
  String get description => throw _privateConstructorUsedError;
  String get placeId => throw _privateConstructorUsedError;
  String get reference => throw _privateConstructorUsedError;
  GmapsStructuredFormatting get structuredFormatting =>
      throw _privateConstructorUsedError;
  List<String> get types => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GmapsPredictionCopyWith<GmapsPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GmapsPredictionCopyWith<$Res> {
  factory $GmapsPredictionCopyWith(
          GmapsPrediction value, $Res Function(GmapsPrediction) then) =
      _$GmapsPredictionCopyWithImpl<$Res, GmapsPrediction>;
  @useResult
  $Res call(
      {String description,
      String placeId,
      String reference,
      GmapsStructuredFormatting structuredFormatting,
      List<String> types});

  $GmapsStructuredFormattingCopyWith<$Res> get structuredFormatting;
}

/// @nodoc
class _$GmapsPredictionCopyWithImpl<$Res, $Val extends GmapsPrediction>
    implements $GmapsPredictionCopyWith<$Res> {
  _$GmapsPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? placeId = null,
    Object? reference = null,
    Object? structuredFormatting = null,
    Object? types = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      structuredFormatting: null == structuredFormatting
          ? _value.structuredFormatting
          : structuredFormatting // ignore: cast_nullable_to_non_nullable
              as GmapsStructuredFormatting,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GmapsStructuredFormattingCopyWith<$Res> get structuredFormatting {
    return $GmapsStructuredFormattingCopyWith<$Res>(_value.structuredFormatting,
        (value) {
      return _then(_value.copyWith(structuredFormatting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GmapsPredictionCopyWith<$Res>
    implements $GmapsPredictionCopyWith<$Res> {
  factory _$$_GmapsPredictionCopyWith(
          _$_GmapsPrediction value, $Res Function(_$_GmapsPrediction) then) =
      __$$_GmapsPredictionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      String placeId,
      String reference,
      GmapsStructuredFormatting structuredFormatting,
      List<String> types});

  @override
  $GmapsStructuredFormattingCopyWith<$Res> get structuredFormatting;
}

/// @nodoc
class __$$_GmapsPredictionCopyWithImpl<$Res>
    extends _$GmapsPredictionCopyWithImpl<$Res, _$_GmapsPrediction>
    implements _$$_GmapsPredictionCopyWith<$Res> {
  __$$_GmapsPredictionCopyWithImpl(
      _$_GmapsPrediction _value, $Res Function(_$_GmapsPrediction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? placeId = null,
    Object? reference = null,
    Object? structuredFormatting = null,
    Object? types = null,
  }) {
    return _then(_$_GmapsPrediction(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      structuredFormatting: null == structuredFormatting
          ? _value.structuredFormatting
          : structuredFormatting // ignore: cast_nullable_to_non_nullable
              as GmapsStructuredFormatting,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GmapsPrediction implements _GmapsPrediction {
  const _$_GmapsPrediction(
      {required this.description,
      required this.placeId,
      required this.reference,
      required this.structuredFormatting,
      required this.types});

  factory _$_GmapsPrediction.fromJson(Map<String, dynamic> json) =>
      _$$_GmapsPredictionFromJson(json);

  @override
  final String description;
  @override
  final String placeId;
  @override
  final String reference;
  @override
  final GmapsStructuredFormatting structuredFormatting;
  @override
  final List<String> types;

  @override
  String toString() {
    return 'GmapsPrediction(description: $description, placeId: $placeId, reference: $reference, structuredFormatting: $structuredFormatting, types: $types)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GmapsPrediction &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.structuredFormatting, structuredFormatting) ||
                other.structuredFormatting == structuredFormatting) &&
            const DeepCollectionEquality().equals(other.types, types));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description, placeId, reference,
      structuredFormatting, const DeepCollectionEquality().hash(types));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GmapsPredictionCopyWith<_$_GmapsPrediction> get copyWith =>
      __$$_GmapsPredictionCopyWithImpl<_$_GmapsPrediction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GmapsPredictionToJson(
      this,
    );
  }
}

abstract class _GmapsPrediction implements GmapsPrediction {
  const factory _GmapsPrediction(
      {required final String description,
      required final String placeId,
      required final String reference,
      required final GmapsStructuredFormatting structuredFormatting,
      required final List<String> types}) = _$_GmapsPrediction;

  factory _GmapsPrediction.fromJson(Map<String, dynamic> json) =
      _$_GmapsPrediction.fromJson;

  @override
  String get description;
  @override
  String get placeId;
  @override
  String get reference;
  @override
  GmapsStructuredFormatting get structuredFormatting;
  @override
  List<String> get types;
  @override
  @JsonKey(ignore: true)
  _$$_GmapsPredictionCopyWith<_$_GmapsPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

GmapsStructuredFormatting _$GmapsStructuredFormattingFromJson(
    Map<String, dynamic> json) {
  return _GmapsStructuredFormatting.fromJson(json);
}

/// @nodoc
mixin _$GmapsStructuredFormatting {
  String get mainText => throw _privateConstructorUsedError;
  String get secondaryText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GmapsStructuredFormattingCopyWith<GmapsStructuredFormatting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GmapsStructuredFormattingCopyWith<$Res> {
  factory $GmapsStructuredFormattingCopyWith(GmapsStructuredFormatting value,
          $Res Function(GmapsStructuredFormatting) then) =
      _$GmapsStructuredFormattingCopyWithImpl<$Res, GmapsStructuredFormatting>;
  @useResult
  $Res call({String mainText, String secondaryText});
}

/// @nodoc
class _$GmapsStructuredFormattingCopyWithImpl<$Res,
        $Val extends GmapsStructuredFormatting>
    implements $GmapsStructuredFormattingCopyWith<$Res> {
  _$GmapsStructuredFormattingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainText = null,
    Object? secondaryText = null,
  }) {
    return _then(_value.copyWith(
      mainText: null == mainText
          ? _value.mainText
          : mainText // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryText: null == secondaryText
          ? _value.secondaryText
          : secondaryText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GmapsStructuredFormattingCopyWith<$Res>
    implements $GmapsStructuredFormattingCopyWith<$Res> {
  factory _$$_GmapsStructuredFormattingCopyWith(
          _$_GmapsStructuredFormatting value,
          $Res Function(_$_GmapsStructuredFormatting) then) =
      __$$_GmapsStructuredFormattingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mainText, String secondaryText});
}

/// @nodoc
class __$$_GmapsStructuredFormattingCopyWithImpl<$Res>
    extends _$GmapsStructuredFormattingCopyWithImpl<$Res,
        _$_GmapsStructuredFormatting>
    implements _$$_GmapsStructuredFormattingCopyWith<$Res> {
  __$$_GmapsStructuredFormattingCopyWithImpl(
      _$_GmapsStructuredFormatting _value,
      $Res Function(_$_GmapsStructuredFormatting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainText = null,
    Object? secondaryText = null,
  }) {
    return _then(_$_GmapsStructuredFormatting(
      mainText: null == mainText
          ? _value.mainText
          : mainText // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryText: null == secondaryText
          ? _value.secondaryText
          : secondaryText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GmapsStructuredFormatting implements _GmapsStructuredFormatting {
  const _$_GmapsStructuredFormatting(
      {required this.mainText, required this.secondaryText});

  factory _$_GmapsStructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$$_GmapsStructuredFormattingFromJson(json);

  @override
  final String mainText;
  @override
  final String secondaryText;

  @override
  String toString() {
    return 'GmapsStructuredFormatting(mainText: $mainText, secondaryText: $secondaryText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GmapsStructuredFormatting &&
            (identical(other.mainText, mainText) ||
                other.mainText == mainText) &&
            (identical(other.secondaryText, secondaryText) ||
                other.secondaryText == secondaryText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, mainText, secondaryText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GmapsStructuredFormattingCopyWith<_$_GmapsStructuredFormatting>
      get copyWith => __$$_GmapsStructuredFormattingCopyWithImpl<
          _$_GmapsStructuredFormatting>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GmapsStructuredFormattingToJson(
      this,
    );
  }
}

abstract class _GmapsStructuredFormatting implements GmapsStructuredFormatting {
  const factory _GmapsStructuredFormatting(
      {required final String mainText,
      required final String secondaryText}) = _$_GmapsStructuredFormatting;

  factory _GmapsStructuredFormatting.fromJson(Map<String, dynamic> json) =
      _$_GmapsStructuredFormatting.fromJson;

  @override
  String get mainText;
  @override
  String get secondaryText;
  @override
  @JsonKey(ignore: true)
  _$$_GmapsStructuredFormattingCopyWith<_$_GmapsStructuredFormatting>
      get copyWith => throw _privateConstructorUsedError;
}
