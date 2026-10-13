import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/data/mappers/entity_mappers.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';

class AccountService {
  AccountService({required HiveService hive}) : _hive = hive;

  final HiveService _hive;

  List<Account> getAll() {
    try {
      return _hive.getAllFromBox(_hive.accountsBox()).map(EntityMappers.accountFromMap).toList();
    } catch (_) {
      return [];
    }
  }

  Account? findById(String id) {
    try {
      final map = _hive.accountsBox().get(id);
      return map == null ? null : EntityMappers.accountFromMap(Map<String, dynamic>.from(map as Map));
    } catch (_) {
      return null;
    }
  }

  Future<void> add(Account account) async {
    try {
      await _hive.putInBox(_hive.accountsBox(), account.id, EntityMappers.accountToMap(account));
    } catch (_) {}
  }

  Future<void> update(Account account) async {
    try {
      await _hive.putInBox(_hive.accountsBox(), account.id, EntityMappers.accountToMap(account));
    } catch (_) {}
  }

  Future<void> delete(String id) async {
    try {
      await _hive.deleteFromBox(_hive.accountsBox(), id);
    } catch (_) {}
  }

  double getTotalBalance() {
    try {
      return getAll().fold(0.0, (sum, a) => sum + a.balance);
    } catch (_) {
      return 0.0;
    }
  }
}
