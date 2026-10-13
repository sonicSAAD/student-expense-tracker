import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationDetailsHelper {
  static const billDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'bill_reminders',
      'Bill Reminders',
      channelDescription: 'Reminders for recurring bills',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  static const budgetDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'budget_alerts',
      'Budget Alerts',
      channelDescription: 'Alerts when budget thresholds are reached',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );
}
