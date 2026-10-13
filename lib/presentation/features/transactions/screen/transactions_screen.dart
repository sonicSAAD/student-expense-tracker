import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/core/utils/date_utils.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/transaction_filter_sheet.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/transaction_list_body.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/transaction_sort_helper.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});
  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  String _query = '';
  TransactionType? _type;

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(settingsProvider);
    final all = ref.watch(transactionsProvider);
    final cats = ref.watch(categoriesProvider);
    final accs = ref.watch(accountsProvider);
    final list = TransactionSortHelper.filter(all, query: _query, type: _type);
    TransactionSortHelper.sort(list, TransactionSort.dateDesc);

    final grouped = <String, List<Transaction>>{};
    for (final t in list) {
      grouped.putIfAbsent(AppDateUtils.groupLabel(t.date), () => []).add(t);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions'), actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => TransactionFilterSheet(
              categories: cats, accounts: accs, selectedType: _type,
              onSelectType: (t) => setState(() => _type = t),
              onClearAll: () => setState(() => _type = null),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addTransaction),
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: const InputDecoration(hintText: 'Search...', prefixIcon: Icon(Icons.search)),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Expanded(
          child: TransactionListBody(grouped: grouped, categories: cats, currencySymbol: s.currencySymbol),
        ),
      ]),
    );
  }
}
