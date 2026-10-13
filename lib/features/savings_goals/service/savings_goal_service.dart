import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/data/mappers/entity_mappers.dart';
import 'package:student_expense_tracker/domain/entities/savings_goal.dart';
import 'package:uuid/uuid.dart';

class SavingsGoalService {
  SavingsGoalService({required HiveService hive, Uuid? uuid})
      : _hive = hive;

  final HiveService _hive;

  List<SavingsGoal> getAll() {
    try {
      return _hive
          .getAllFromBox(_hive.savingsGoalsBox())
          .map(EntityMappers.savingsGoalFromMap)
          .toList();
    } catch (_) {
      return [];
    }
  }

  SavingsGoal? findById(String id) {
    try {
      final map = _hive.savingsGoalsBox().get(id);
      if (map == null) return null;
      return EntityMappers.savingsGoalFromMap(
        Map<String, dynamic>.from(map as Map),
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> add(SavingsGoal goal) async {
    try {
      await _hive.putInBox(
        _hive.savingsGoalsBox(),
        goal.id,
        EntityMappers.savingsGoalToMap(goal),
      );
    } catch (_) {}
  }

  Future<void> update(SavingsGoal goal) async {
    try {
      await _hive.putInBox(
        _hive.savingsGoalsBox(),
        goal.id,
        EntityMappers.savingsGoalToMap(goal),
      );
    } catch (_) {}
  }

  Future<void> delete(String id) async {
    try {
      await _hive.deleteFromBox(_hive.savingsGoalsBox(), id);
    } catch (_) {}
  }

  Future<void> addMoney(String goalId, double amount) async {
    final goal = findById(goalId);
    if (goal == null) return;
    await update(SavingsGoal(
      id: goal.id,
      name: goal.name,
      targetAmount: goal.targetAmount,
      currentAmount: goal.currentAmount + amount,
      deadline: goal.deadline,
      icon: goal.icon,
    ));
  }
}
