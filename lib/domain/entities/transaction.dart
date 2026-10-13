import 'package:equatable/equatable.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';

class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.accountId,
    required this.date,
    this.note = '',
    this.isRecurring = false,
    this.recurringFrequency,
    this.attachmentPath,
  });

  final String id;
  final double amount;
  final TransactionType type;
  final String categoryId;
  final String accountId;
  final String note;
  final DateTime date;
  final bool isRecurring;
  final BillFrequency? recurringFrequency;
  final String? attachmentPath;

  @override
  List<Object?> get props => [
        id,
        amount,
        type,
        categoryId,
        accountId,
        note,
        date,
        isRecurring,
        recurringFrequency,
        attachmentPath,
      ];
}
