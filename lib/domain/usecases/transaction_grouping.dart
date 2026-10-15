import 'package:student_expense_tracker/core/utils/date_utils.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';

/// Buckets transactions by their human readable date label, preserving order.
Map<String, List<Transaction>> groupByDateLabel(
  List<Transaction> transactions,
) {
  final grouped = <String, List<Transaction>>{};
  for (final t in transactions) {
    grouped.putIfAbsent(AppDateUtils.groupLabel(t.date), () => []).add(t);
  }
  return grouped;
}
