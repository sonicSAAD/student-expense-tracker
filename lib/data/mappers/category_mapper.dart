import 'package:student_expense_tracker/domain/entities/category.dart';

class CategoryMapper {
  static Map<String, dynamic> toMap(Category c) => {
        'id': c.id,
        'name': c.name,
        'icon': c.icon,
        'color': c.color,
        'monthlyBudgetLimit': c.monthlyBudgetLimit,
      };

  static Category fromMap(Map map) => Category(
        id: map['id'] as String,
        name: map['name'] as String,
        icon: map['icon'] as String,
        color: map['color'] as int,
        monthlyBudgetLimit:
            (map['monthlyBudgetLimit'] as num?)?.toDouble() ?? 0,
      );
}
