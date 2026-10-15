import 'package:hive/hive.dart';

/// Exception-tolerant wrapper around a single Hive box.
///
/// Every service reads and writes boxes with the same contract, so the
/// try/catch handling of local storage anomalies lives here once instead of
/// being repeated in each service method.
class BoxIo {
  const BoxIo(this._box);

  final Box _box;

  List<T> readAll<T>(T Function(Map map) fromMap) {
    try {
      return _box.values
          .map((e) => fromMap(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  T? readById<T>(String id, T Function(Map map) fromMap) {
    try {
      final map = _box.get(id);
      if (map == null) return null;
      return fromMap(Map<String, dynamic>.from(map as Map));
    } catch (_) {
      return null;
    }
  }

  Future<void> put(String key, Map value) async {
    try {
      await _box.put(key, value);
    } catch (_) {}
  }

  Future<void> remove(String key) async {
    try {
      await _box.delete(key);
    } catch (_) {}
  }
}
