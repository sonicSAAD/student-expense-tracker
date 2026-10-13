import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:student_expense_tracker/core/services/notification_details_helper.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
    );
    _initialized = true;
  }

  Future<void> scheduleBillReminder(RecurringBill bill) async {
    if (!bill.reminderEnabled) return;
    final reminderDate =
        bill.dueDate.subtract(Duration(days: bill.reminderDaysBefore));
    if (reminderDate.isBefore(DateTime.now())) return;
    final tzDate = tz.TZDateTime.from(reminderDate, tz.local);
    await _plugin.zonedSchedule(
      bill.id.hashCode,
      'Upcoming Bill: ${bill.name}',
      '${bill.name} is due on ${bill.dueDate.day}/${bill.dueDate.month}',
      tzDate,
      NotificationDetailsHelper.billDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelBillReminder(String billId) async {
    await _plugin.cancel(billId.hashCode);
  }

  Future<void> showBudgetAlert({
    required String categoryName,
    required int percentage,
  }) async {
    final body = percentage >= 100
        ? 'You have exceeded your budget for $categoryName!'
        : 'You have used $percentage% of your $categoryName budget.';
    await _plugin.show(
      categoryName.hashCode,
      'Budget Alert: $categoryName',
      body,
      NotificationDetailsHelper.budgetDetails,
    );
  }
}
