import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/usecases/transaction_grouping.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/transaction_filter_action_button.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/transaction_list_body.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/transaction_search_field.dart';
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
    final grouped = groupByDateLabel(list);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          TransactionFilterActionButton(
            categories: cats,
            accounts: accs,
            selectedType: _type,
            onSelectType: (t) => setState(() => _type = t),
            onClearAll: () => setState(() => _type = null),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addTransaction),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          TransactionSearchField(onChanged: (v) => setState(() => _query = v)),
          Expanded(
            child: TransactionListBody(
              grouped: grouped,
              categories: cats,
              currencySymbol: s.currencySymbol,
            ),
          ),
        ],
      ),
    );
  }
}
