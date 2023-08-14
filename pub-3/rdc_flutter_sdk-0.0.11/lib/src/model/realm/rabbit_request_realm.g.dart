// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rabbit_request_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RabbitRequestRealm extends _RabbitRequestRealm
    with
        RealmEntity,
        RealmObjectBase,
        RealmObject,
        RealmBaseModel<RabbitRequest> {
  static var _defaultsSet = false;

  @override
  RabbitRequest mapFromRealm() {
    return RabbitRequest()
      ..id = id
      ..memberId = memberId
      ..ssoId = ssoId
      ..globalId = globalId
      ..sdkVersion = sdkVersion
      ..touchPoint = touchPoint
      ..sessionEvent = sessionEvent
      ..sessionId = sessionId
      ..eventName = eventName
      ..eventValue = eventValue
      ..osVer = osVer
      ..osType = osType
      ..display = display
      ..localeCountry = localeCountry
      ..localeLang = localeLang
      ..latitude = latitude.isEmpty ? null : latitude
      ..longitude = longitude.isEmpty ? null : longitude
      ..maid = maid.isEmpty ? null : maid
      ..device = device
      ..model = model
      ..brandName = brandName
      ..board = board
      ..appVer = appVer
      ..appVerNum = appVerNum
      ..prevAppVer = prevAppVer.isEmpty ? null : prevAppVer
      ..prevAppVerNum = prevAppVerNum.isEmpty ? null : prevAppVerNum
      ..dataLayer = dataLayer != null ? json.decode(dataLayer!) : null
      ..time = time
      ..isSend = isSend;
  }

  RabbitRequestRealm(
    int id,
    String memberId,
    String ssoId,
    String globalId,
    String sdkVersion,
    String touchPoint,
    String sessionEvent,
    String sessionId,
    String eventName,
    String eventValue,
    String osVer,
    String osType,
    String display,
    String localeCountry,
    String localeLang,
    String latitude,
    String longitude,
    String maid,
    String device,
    String model,
    String brandName,
    String board,
    String appVer,
    String appVerNum,
    String prevAppVer,
    String prevAppVerNum,
    String time, {
    String? dataLayer,
    bool isSend = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<RabbitRequestRealm>({
        'isSend': false,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'memberId', memberId);
    RealmObjectBase.set(this, 'ssoId', ssoId);
    RealmObjectBase.set(this, 'globalId', globalId);
    RealmObjectBase.set(this, 'sdkVersion', sdkVersion);
    RealmObjectBase.set(this, 'touchPoint', touchPoint);
    RealmObjectBase.set(this, 'sessionEvent', sessionEvent);
    RealmObjectBase.set(this, 'sessionId', sessionId);
    RealmObjectBase.set(this, 'eventName', eventName);
    RealmObjectBase.set(this, 'eventValue', eventValue);
    RealmObjectBase.set(this, 'osVer', osVer);
    RealmObjectBase.set(this, 'osType', osType);
    RealmObjectBase.set(this, 'display', display);
    RealmObjectBase.set(this, 'localeCountry', localeCountry);
    RealmObjectBase.set(this, 'localeLang', localeLang);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
    RealmObjectBase.set(this, 'maid', maid);
    RealmObjectBase.set(this, 'device', device);
    RealmObjectBase.set(this, 'model', model);
    RealmObjectBase.set(this, 'brandName', brandName);
    RealmObjectBase.set(this, 'board', board);
    RealmObjectBase.set(this, 'appVer', appVer);
    RealmObjectBase.set(this, 'appVerNum', appVerNum);
    RealmObjectBase.set(this, 'prevAppVer', prevAppVer);
    RealmObjectBase.set(this, 'prevAppVerNum', prevAppVerNum);
    RealmObjectBase.set(this, 'dataLayer', dataLayer);
    RealmObjectBase.set(this, 'time', time);
    RealmObjectBase.set(this, 'isSend', isSend);
  }

  RabbitRequestRealm._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get memberId =>
      RealmObjectBase.get<String>(this, 'memberId') as String;
  @override
  set memberId(String value) => RealmObjectBase.set(this, 'memberId', value);

  @override
  String get ssoId => RealmObjectBase.get<String>(this, 'ssoId') as String;
  @override
  set ssoId(String value) => RealmObjectBase.set(this, 'ssoId', value);

  @override
  String get globalId =>
      RealmObjectBase.get<String>(this, 'globalId') as String;
  @override
  set globalId(String value) => RealmObjectBase.set(this, 'globalId', value);

  @override
  String get sdkVersion =>
      RealmObjectBase.get<String>(this, 'sdkVersion') as String;
  @override
  set sdkVersion(String value) =>
      RealmObjectBase.set(this, 'sdkVersion', value);

  @override
  String get touchPoint =>
      RealmObjectBase.get<String>(this, 'touchPoint') as String;
  @override
  set touchPoint(String value) =>
      RealmObjectBase.set(this, 'touchPoint', value);

  @override
  String get sessionEvent =>
      RealmObjectBase.get<String>(this, 'sessionEvent') as String;
  @override
  set sessionEvent(String value) =>
      RealmObjectBase.set(this, 'sessionEvent', value);

  @override
  String get sessionId =>
      RealmObjectBase.get<String>(this, 'sessionId') as String;
  @override
  set sessionId(String value) => RealmObjectBase.set(this, 'sessionId', value);

  @override
  String get eventName =>
      RealmObjectBase.get<String>(this, 'eventName') as String;
  @override
  set eventName(String value) => RealmObjectBase.set(this, 'eventName', value);

  @override
  String get eventValue =>
      RealmObjectBase.get<String>(this, 'eventValue') as String;
  @override
  set eventValue(String value) =>
      RealmObjectBase.set(this, 'eventValue', value);

  @override
  String get osVer => RealmObjectBase.get<String>(this, 'osVer') as String;
  @override
  set osVer(String value) => RealmObjectBase.set(this, 'osVer', value);

  @override
  String get osType => RealmObjectBase.get<String>(this, 'osType') as String;
  @override
  set osType(String value) => RealmObjectBase.set(this, 'osType', value);

  @override
  String get display => RealmObjectBase.get<String>(this, 'display') as String;
  @override
  set display(String value) => RealmObjectBase.set(this, 'display', value);

  @override
  String get localeCountry =>
      RealmObjectBase.get<String>(this, 'localeCountry') as String;
  @override
  set localeCountry(String value) =>
      RealmObjectBase.set(this, 'localeCountry', value);

  @override
  String get localeLang =>
      RealmObjectBase.get<String>(this, 'localeLang') as String;
  @override
  set localeLang(String value) =>
      RealmObjectBase.set(this, 'localeLang', value);

  @override
  String get latitude =>
      RealmObjectBase.get<String>(this, 'latitude') as String;
  @override
  set latitude(String value) => RealmObjectBase.set(this, 'latitude', value);

  @override
  String get longitude =>
      RealmObjectBase.get<String>(this, 'longitude') as String;
  @override
  set longitude(String value) => RealmObjectBase.set(this, 'longitude', value);

  @override
  String get maid => RealmObjectBase.get<String>(this, 'maid') as String;
  @override
  set maid(String value) => RealmObjectBase.set(this, 'maid', value);

  @override
  String get device => RealmObjectBase.get<String>(this, 'device') as String;
  @override
  set device(String value) => RealmObjectBase.set(this, 'device', value);

  @override
  String get model => RealmObjectBase.get<String>(this, 'model') as String;
  @override
  set model(String value) => RealmObjectBase.set(this, 'model', value);

  @override
  String get brandName =>
      RealmObjectBase.get<String>(this, 'brandName') as String;
  @override
  set brandName(String value) => RealmObjectBase.set(this, 'brandName', value);

  @override
  String get board => RealmObjectBase.get<String>(this, 'board') as String;
  @override
  set board(String value) => RealmObjectBase.set(this, 'board', value);

  @override
  String get appVer => RealmObjectBase.get<String>(this, 'appVer') as String;
  @override
  set appVer(String value) => RealmObjectBase.set(this, 'appVer', value);

  @override
  String get appVerNum =>
      RealmObjectBase.get<String>(this, 'appVerNum') as String;
  @override
  set appVerNum(String value) => RealmObjectBase.set(this, 'appVerNum', value);

  @override
  String get prevAppVer =>
      RealmObjectBase.get<String>(this, 'prevAppVer') as String;
  @override
  set prevAppVer(String value) =>
      RealmObjectBase.set(this, 'prevAppVer', value);

  @override
  String get prevAppVerNum =>
      RealmObjectBase.get<String>(this, 'prevAppVerNum') as String;
  @override
  set prevAppVerNum(String value) =>
      RealmObjectBase.set(this, 'prevAppVerNum', value);

  @override
  String? get dataLayer =>
      RealmObjectBase.get<String>(this, 'dataLayer') as String?;
  @override
  set dataLayer(String? value) => RealmObjectBase.set(this, 'dataLayer', value);

  @override
  String get time => RealmObjectBase.get<String>(this, 'time') as String;
  @override
  set time(String value) => RealmObjectBase.set(this, 'time', value);

  @override
  bool get isSend => RealmObjectBase.get<bool>(this, 'isSend') as bool;
  @override
  set isSend(bool value) => RealmObjectBase.set(this, 'isSend', value);

  @override
  Stream<RealmObjectChanges<RabbitRequestRealm>> get changes =>
      RealmObjectBase.getChanges<RabbitRequestRealm>(this);

  @override
  RabbitRequestRealm freeze() =>
      RealmObjectBase.freezeObject<RabbitRequestRealm>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RabbitRequestRealm._);
    return const SchemaObject(
        ObjectType.realmObject, RabbitRequestRealm, 'RabbitRequestRealm', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('memberId', RealmPropertyType.string),
      SchemaProperty('ssoId', RealmPropertyType.string),
      SchemaProperty('globalId', RealmPropertyType.string),
      SchemaProperty('sdkVersion', RealmPropertyType.string),
      SchemaProperty('touchPoint', RealmPropertyType.string),
      SchemaProperty('sessionEvent', RealmPropertyType.string),
      SchemaProperty('sessionId', RealmPropertyType.string),
      SchemaProperty('eventName', RealmPropertyType.string),
      SchemaProperty('eventValue', RealmPropertyType.string),
      SchemaProperty('osVer', RealmPropertyType.string),
      SchemaProperty('osType', RealmPropertyType.string),
      SchemaProperty('display', RealmPropertyType.string),
      SchemaProperty('localeCountry', RealmPropertyType.string),
      SchemaProperty('localeLang', RealmPropertyType.string),
      SchemaProperty('latitude', RealmPropertyType.string),
      SchemaProperty('longitude', RealmPropertyType.string),
      SchemaProperty('maid', RealmPropertyType.string),
      SchemaProperty('device', RealmPropertyType.string),
      SchemaProperty('model', RealmPropertyType.string),
      SchemaProperty('brandName', RealmPropertyType.string),
      SchemaProperty('board', RealmPropertyType.string),
      SchemaProperty('appVer', RealmPropertyType.string),
      SchemaProperty('appVerNum', RealmPropertyType.string),
      SchemaProperty('prevAppVer', RealmPropertyType.string),
      SchemaProperty('prevAppVerNum', RealmPropertyType.string),
      SchemaProperty('dataLayer', RealmPropertyType.string, optional: true),
      SchemaProperty('time', RealmPropertyType.string),
      SchemaProperty('isSend', RealmPropertyType.bool),
    ]);
  }
}
