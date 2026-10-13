import 'package:hive/hive.dart';
import 'package:student_expense_tracker/core/constants/app_constants.dart';
import 'package:student_expense_tracker/data/mappers/entity_mappers.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/app_settings.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:uuid/uuid.dart';

class HiveSeedHelper {
  static const _uuid = Uuid();

  static Future<void> seedDefaultsIfNeeded({
    required Box categories,
    required Box accounts,
    required Box settings,
  }) async {
    if (categories.isEmpty) {
      for (final cat in AppConstants.defaultCategories) {
        final id = _uuid.v4();
        await categories.put(
          id,
          EntityMappers.categoryToMap(Category(
            id: id,
            name: cat['name'] as String,
            icon: cat['icon'] as String,
            color: cat['color'] as int,
          )),
        );
      }
    }

    if (accounts.isEmpty) {
      for (final acc in AppConstants.defaultAccounts) {
        final id = _uuid.v4();
        await accounts.put(
          id,
          EntityMappers.accountToMap(Account(
            id: id,
            name: acc['name'] as String,
            icon: acc['icon'] as String,
            balance: (acc['balance'] as num).toDouble(),
          )),
        );
      }
    }

    if (!settings.containsKey('app')) {
      await settings.put(
        'app',
        EntityMappers.settingsToMap(const AppSettings()),
      );
    }
  }
}
