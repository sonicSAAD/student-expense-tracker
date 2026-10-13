import 'package:student_expense_tracker/domain/entities/budget.dart';

class BudgetMapper {
  static Map<String, dynamic> toMap(Budget b) => {
        'categoryId': b.categoryId,
        'month': b.month,
        'limitAmount': b.limitAmount,
        'spentAmount': b.spentAmount,
      };

  static Budget fromMap(Map map) => Budget(
        categoryId: map['categoryId'] as String,
        month: map['month'] as String,
        limitAmount: (map['limitAmount'] as num).toDouble(),
        spentAmount: (map['spentAmount'] as num?)?.toDouble() ?? 0,
      );
}
