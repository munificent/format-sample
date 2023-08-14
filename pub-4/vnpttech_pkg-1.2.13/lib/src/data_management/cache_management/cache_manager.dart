import 'package:vnpttech_pkg/src/data_management/cache_management/cache_storage.dart';
import 'package:vnpttech_pkg/src/data_management/cache_management/i_cache_manager.dart';

class CacheManager implements ICacheManager {
  final CacheStorage _db;

  CacheManager(this._db);

  @override
  Future<void> addCache(dynamic cache, String key) async {
    await _db.addCache(cache, key);
  }

  @override
  Future<dynamic> getCache(String key) async {
    var data = await _db.getCache(key);
    return data;
  }

  @override
  Future<void> clearCache(String key) async {
    await _db.clearCache(key);
  }

  @override
  Future<bool> checkCache(String key) async {
    return await _db.checkCache(key);
  }

  @override
  Future clearAllCache() async {
    return await _db.clearAllCache();
  }
}
