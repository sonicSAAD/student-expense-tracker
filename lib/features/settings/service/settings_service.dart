import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/data/mappers/entity_mappers.dart';
import 'package:student_expense_tracker/domain/entities/app_settings.dart';

class SettingsService {
  SettingsService({required HiveService hive}) : _hive = hive;

  final HiveService _hive;

  AppSettings get() {
    try {
      final map = _hive.settingsBox().get('app');
      if (map == null) return const AppSettings();
      return EntityMappers.settingsFromMap(
        Map<String, dynamic>.from(map as Map),
      );
    } catch (_) {
      return const AppSettings();
    }
  }

  Future<void> save(AppSettings settings) async {
    try {
      await _hive.putInBox(
        _hive.settingsBox(),
        'app',
        EntityMappers.settingsToMap(settings),
      );
    } catch (_) {}
  }
}
