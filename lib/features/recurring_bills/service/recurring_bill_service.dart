import 'package:student_expense_tracker/core/services/box_io.dart';
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

  BoxIo get _box => BoxIo(_hive.recurringBillsBox());

  List<RecurringBill> getAll() =>
      _box.readAll(EntityMappers.recurringBillFromMap)
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

  RecurringBill? findById(String id) =>
      _box.readById(id, EntityMappers.recurringBillFromMap);

  Future<void> add(RecurringBill bill) async {
    await _box.put(bill.id, EntityMappers.recurringBillToMap(bill));
    await _schedule(bill);
  }

  Future<void> update(RecurringBill bill) async {
    await _cancel(bill.id);
    await _box.put(bill.id, EntityMappers.recurringBillToMap(bill));
    await _schedule(bill);
  }

  Future<void> delete(String id) async {
    await _cancel(id);
    await _box.remove(id);
  }

  Future<void> _schedule(RecurringBill bill) async {
    try {
      await _notifications.scheduleBillReminder(bill);
    } catch (_) {}
  }

  Future<void> _cancel(String id) async {
    try {
      await _notifications.cancelBillReminder(id);
    } catch (_) {}
  }
}
