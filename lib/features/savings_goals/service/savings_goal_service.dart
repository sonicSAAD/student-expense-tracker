import 'package:student_expense_tracker/core/services/box_io.dart';
import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/data/mappers/entity_mappers.dart';
import 'package:student_expense_tracker/domain/entities/savings_goal.dart';
import 'package:uuid/uuid.dart';

class SavingsGoalService {
  SavingsGoalService({required HiveService hive, Uuid? uuid}) : _hive = hive;

  final HiveService _hive;

  BoxIo get _box => BoxIo(_hive.savingsGoalsBox());

  List<SavingsGoal> getAll() => _box.readAll(EntityMappers.savingsGoalFromMap);

  SavingsGoal? findById(String id) =>
      _box.readById(id, EntityMappers.savingsGoalFromMap);

  Future<void> add(SavingsGoal goal) =>
      _box.put(goal.id, EntityMappers.savingsGoalToMap(goal));

  Future<void> update(SavingsGoal goal) =>
      _box.put(goal.id, EntityMappers.savingsGoalToMap(goal));

  Future<void> delete(String id) => _box.remove(id);

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
