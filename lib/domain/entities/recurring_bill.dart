import 'package:equatable/equatable.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';

class RecurringBill extends Equatable {
  const RecurringBill({
    required this.id,
    required this.name,
    required this.amount,
    required this.categoryId,
    required this.dueDate,
    required this.frequency,
    this.reminderEnabled = true,
    this.reminderDaysBefore = 2,
    this.accountId,
  });

  final String id;
  final String name;
  final double amount;
  final String categoryId;
  final DateTime dueDate;
  final BillFrequency frequency;
  final bool reminderEnabled;
  final int reminderDaysBefore;
  final String? accountId;

  @override
  List<Object?> get props => [
        id,
        name,
        amount,
        categoryId,
        dueDate,
        frequency,
        reminderEnabled,
        reminderDaysBefore,
        accountId,
      ];
}
