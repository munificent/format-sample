import 'package:vnpttech_pkg/src/data_management/device_management/vnpttech_device_model.dart';
import 'vnpttech_device_interface.dart';
import 'vnpttech_device_storage.dart';

class DeviceRepository implements IDeviceRepository {
  final DeviceStorage _db;

  DeviceRepository(this._db);

  @override
  Future<void> insert(DeviceManagement deviceManagement, String key) async {
    await _db.insert(deviceManagement.toJson(), key);
  }

  @override
  Future<dynamic> getString(String key) async {
    var data = await _db.getString(key);
    return data;
  }

  @override
  Future<void> delete(String key) async {
    await _db.remove(key);
  }
}
