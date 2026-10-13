import 'package:flutter/material.dart';
import 'package:student_expense_tracker/core/utils/currency_formatter.dart';
import 'package:student_expense_tracker/core/utils/icon_helper.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    required this.category,
    required this.currencySymbol,
    required this.onTap,
    required this.onDelete,
  });

  final Transaction transaction;
  final Category? category;
  final String currencySymbol;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final color = category != null
        ? Color(category!.color)
        : (isIncome ? const Color(0xFF1A1A1A) : const Color(0xFFB00020));

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.12),
        child: Icon(
          iconFromName(category?.icon ?? 'receipt_long'),
          color: color,
          size: 20,
        ),
      ),
      title: Text(
        category?.name ?? 'Other',
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: transaction.note.isNotEmpty
          ? Text(
              transaction.note,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: Text(
        '${isIncome ? '+' : '-'}${CurrencyFormatter.format(transaction.amount, currencySymbol)}',
        style: TextStyle(
          color: isIncome ? const Color(0xFF1A1A1A) : const Color(0xFFB00020),
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
      onLongPress: onDelete,
    );
  }
}
