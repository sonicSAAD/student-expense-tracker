import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/core/services/notification_service.dart';
import 'package:student_expense_tracker/data/mappers/entity_mappers.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:uuid/uuid.dart';

class RecurringBillService {
  RecurringBillService({
    required HiveService hive,
    NotificationService? notifications,
    Uuid? uuid,
  })  : _hive = hive,
        _notifications = notifications ?? NotificationService.instance;

  final HiveService _hive;
  final NotificationService _notifications;

  List<RecurringBill> getAll() {
    try {
      return _hive
          .getAllFromBox(_hive.recurringBillsBox())
          .map(EntityMappers.recurringBillFromMap)
          .toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } catch (_) {
      return [];
    }
  }

  RecurringBill? findById(String id) {
    try {
      final map = _hive.recurringBillsBox().get(id);
      if (map == null) return null;
      return EntityMappers.recurringBillFromMap(
        Map<String, dynamic>.from(map as Map),
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> add(RecurringBill bill) async {
    try {
      await _hive.putInBox(
        _hive.recurringBillsBox(),
        bill.id,
        EntityMappers.recurringBillToMap(bill),
      );
      await _notifications.scheduleBillReminder(bill);
    } catch (_) {}
  }

  Future<void> update(RecurringBill bill) async {
    try {
      await _notifications.cancelBillReminder(bill.id);
      await _hive.putInBox(
        _hive.recurringBillsBox(),
        bill.id,
        EntityMappers.recurringBillToMap(bill),
      );
      await _notifications.scheduleBillReminder(bill);
    } catch (_) {}
  }

  Future<void> delete(String id) async {
    try {
      await _notifications.cancelBillReminder(id);
      await _hive.deleteFromBox(_hive.recurringBillsBox(), id);
    } catch (_) {}
  }
}
