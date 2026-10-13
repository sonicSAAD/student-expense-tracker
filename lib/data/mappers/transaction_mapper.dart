import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';

class TransactionMapper {
  static Map<String, dynamic> toMap(Transaction t) => {
        'id': t.id,
        'amount': t.amount,
        'type': t.type.name,
        'categoryId': t.categoryId,
        'accountId': t.accountId,
        'note': t.note,
        'date': t.date.toIso8601String(),
        'isRecurring': t.isRecurring,
        'recurringFrequency': t.recurringFrequency?.name,
        'attachmentPath': t.attachmentPath,
      };

  static Transaction fromMap(Map map) => Transaction(
        id: map['id'] as String,
        amount: (map['amount'] as num).toDouble(),
        type: TransactionType.values.byName(map['type'] as String),
        categoryId: map['categoryId'] as String,
        accountId: map['accountId'] as String,
        note: map['note'] as String? ?? '',
        date: DateTime.parse(map['date'] as String),
        isRecurring: map['isRecurring'] as bool? ?? false,
        recurringFrequency: map['recurringFrequency'] != null
            ? BillFrequency.values.byName(map['recurringFrequency'] as String)
            : null,
        attachmentPath: map['attachmentPath'] as String?,
      );
}
