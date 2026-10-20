import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/router/app_router.dart';

/// Initial values for the add / edit transaction form.
class TransactionFormPrefill {
  const TransactionFormPrefill({
    required this.type,
    required this.categoryId,
    required this.accountId,
    required this.amountText,
    required this.note,
  });

  final TransactionType type;
  final String? categoryId;
  final String? accountId;
  final String amountText;
  final String note;

  /// Reads [transactionId] when editing and falls back to a blank form.
  static TransactionFormPrefill of(
    AppFeatureServices repo,
    String? transactionId,
    TransactionTypeArg initialType,
  ) {
    final tx = transactionId == null
        ? null
        : repo.transactions.findById(transactionId);
    return TransactionFormPrefill(
      type: tx?.type ??
          (initialType == TransactionTypeArg.income
              ? TransactionType.income
              : TransactionType.expense),
      categoryId: tx?.categoryId,
      accountId: tx?.accountId,
      amountText: tx == null ? '' : tx.amount.toString(),
      note: tx?.note ?? '',
    );
  }
}
