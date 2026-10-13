import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';

enum TransactionSort { dateDesc, dateAsc, amountDesc, amountAsc }

class TransactionSortHelper {
  static List<Transaction> filter(
    List<Transaction> list, {
    String query = '',
    String? categoryId,
    String? accountId,
    TransactionType? type,
  }) {
    return list.where((t) {
      if (categoryId != null && t.categoryId != categoryId) return false;
      if (accountId != null && t.accountId != accountId) return false;
      if (type != null && t.type != type) return false;
      if (query.isNotEmpty) {
        final q = query.toLowerCase();
        final matchesNote = t.note.toLowerCase().contains(q);
        final matchesAmount = t.amount.toString().contains(q);
        if (!matchesNote && !matchesAmount) return false;
      }
      return true;
    }).toList();
  }

  static void sort(List<Transaction> list, TransactionSort sort) {
    switch (sort) {
      case TransactionSort.dateDesc:
        list.sort((a, b) => b.date.compareTo(a.date));
      case TransactionSort.dateAsc:
        list.sort((a, b) => a.date.compareTo(b.date));
      case TransactionSort.amountDesc:
        list.sort((a, b) => b.amount.compareTo(a.amount));
      case TransactionSort.amountAsc:
        list.sort((a, b) => a.amount.compareTo(b.amount));
    }
  }
}
