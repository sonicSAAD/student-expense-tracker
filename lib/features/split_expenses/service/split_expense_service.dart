import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/data/mappers/entity_mappers.dart';
import 'package:student_expense_tracker/domain/entities/split_expense.dart';

class SplitExpenseService {
  SplitExpenseService({required HiveService hive}) : _hive = hive;

  final HiveService _hive;

  List<SplitExpense> getAll() {
    try {
      return _hive.getAllFromBox(_hive.splitExpensesBox())
          .map(EntityMappers.splitExpenseFromMap).toList()
        ..sort((a, b) => b.date.compareTo(a.date));
    } catch (_) {
      return [];
    }
  }

  SplitExpense? findById(String id) {
    try {
      final map = _hive.splitExpensesBox().get(id);
      return map == null ? null : EntityMappers.splitExpenseFromMap(Map<String, dynamic>.from(map as Map));
    } catch (_) {
      return null;
    }
  }

  Future<void> add(SplitExpense expense) async {
    try {
      await _hive.putInBox(_hive.splitExpensesBox(), expense.id, EntityMappers.splitExpenseToMap(expense));
    } catch (_) {}
  }

  Future<void> update(SplitExpense expense) async {
    try {
      await _hive.putInBox(_hive.splitExpensesBox(), expense.id, EntityMappers.splitExpenseToMap(expense));
    } catch (_) {}
  }

  Future<void> delete(String id) async {
    try {
      await _hive.deleteFromBox(_hive.splitExpensesBox(), id);
    } catch (_) {}
  }

  Future<void> markParticipantPaid({required String splitId, required int participantIndex, required bool paid}) async {
    final exp = findById(splitId);
    if (exp == null || participantIndex < 0 || participantIndex >= exp.participants.length) return;
    final list = List<SplitParticipant>.from(exp.participants);
    list[participantIndex] = list[participantIndex].copyWith(hasPaid: paid);
    await update(exp.copyWith(participants: list, isSettled: list.every((p) => p.hasPaid)));
  }
}
