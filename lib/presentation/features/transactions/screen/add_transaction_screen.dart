import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/add_transaction_form_fields.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/add_transaction_type_selector.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/router/app_router.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key, this.transactionId, this.initialType = TransactionTypeArg.expense});
  final String? transactionId;
  final TransactionTypeArg initialType;
  @override
  ConsumerState<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  final _amount = TextEditingController();
  final _note = TextEditingController();
  TransactionType _type = TransactionType.expense;
  String? _catId;
  String? _accId;

  @override
  void initState() {
    super.initState();
    _type = widget.initialType == TransactionTypeArg.income ? TransactionType.income : TransactionType.expense;
  }

  Future<void> _submit(BuildContext ctx) async {
    final amt = double.tryParse(_amount.text);
    if (amt == null || amt <= 0 || _catId == null || _accId == null) return;
    await saveTransactionAction(
      repo: ref.read(appFeatureProvider), id: widget.transactionId, amount: amt,
      type: _type, categoryId: _catId!, accountId: _accId!, note: _note.text.trim(),
    );
    ref.read(appRefreshProvider.notifier).refresh();
    if (ctx.mounted) ctx.pop();
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(settingsProvider);
    final cats = ref.watch(categoriesProvider);
    final accs = ref.watch(accountsProvider);
    _catId ??= cats.firstOrNull?.id;
    _accId ??= accs.firstOrNull?.id;

    return Scaffold(
      appBar: AppBar(title: Text(widget.transactionId != null ? 'Edit Transaction' : 'Add Transaction')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        AddTransactionTypeSelector(type: _type, onChanged: (t) => setState(() => _type = t)),
        const SizedBox(height: 16),
        TextField(controller: _amount, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Amount', prefixText: '${s.currencySymbol} ')),
        const SizedBox(height: 16),
        CategoryDropdownField(categories: cats, selectedId: _catId, onChanged: (v) => setState(() => _catId = v)),
        const SizedBox(height: 16),
        AccountDropdownField(accounts: accs, selectedId: _accId, onChanged: (v) => setState(() => _accId = v)),
        const SizedBox(height: 16),
        TextField(controller: _note, decoration: const InputDecoration(labelText: 'Note')),
        const SizedBox(height: 24),
        FilledButton(onPressed: () => _submit(context), child: const Text('Save Transaction')),
      ]),
    );
  }
}
