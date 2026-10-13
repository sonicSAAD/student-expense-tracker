import 'package:student_expense_tracker/domain/entities/savings_goal.dart';

class GoalMapper {
  static Map<String, dynamic> toMap(SavingsGoal g) => {
        'id': g.id,
        'name': g.name,
        'targetAmount': g.targetAmount,
        'currentAmount': g.currentAmount,
        'deadline': g.deadline?.toIso8601String(),
        'icon': g.icon,
      };

  static SavingsGoal fromMap(Map map) => SavingsGoal(
        id: map['id'] as String,
        name: map['name'] as String,
        targetAmount: (map['targetAmount'] as num).toDouble(),
        currentAmount: (map['currentAmount'] as num?)?.toDouble() ?? 0,
        deadline: map['deadline'] != null
            ? DateTime.parse(map['deadline'] as String)
            : null,
        icon: map['icon'] as String? ?? 'savings',
      );
}
