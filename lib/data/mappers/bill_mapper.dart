import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';

class BillMapper {
  static Map<String, dynamic> toMap(RecurringBill b) => {
        'id': b.id,
        'name': b.name,
        'amount': b.amount,
        'categoryId': b.categoryId,
        'dueDate': b.dueDate.toIso8601String(),
        'frequency': b.frequency.name,
        'reminderEnabled': b.reminderEnabled,
        'reminderDaysBefore': b.reminderDaysBefore,
        'accountId': b.accountId,
      };

  static RecurringBill fromMap(Map map) => RecurringBill(
        id: map['id'] as String,
        name: map['name'] as String,
        amount: (map['amount'] as num).toDouble(),
        categoryId: map['categoryId'] as String,
        dueDate: DateTime.parse(map['dueDate'] as String),
        frequency: BillFrequency.values.byName(map['frequency'] as String),
        reminderEnabled: map['reminderEnabled'] as bool? ?? true,
        reminderDaysBefore: map['reminderDaysBefore'] as int? ?? 2,
        accountId: map['accountId'] as String?,
      );
}
