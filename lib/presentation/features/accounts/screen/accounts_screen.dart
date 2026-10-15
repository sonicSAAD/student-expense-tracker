import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/presentation/features/accounts/screen/account_form_dialog.dart';
import 'package:student_expense_tracker/presentation/features/accounts/screen/account_tile.dart';
import 'package:student_expense_tracker/presentation/features/accounts/screen/account_transfer_dialog.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final accounts = ref.watch(accountsProvider);
    final repo = ref.watch(appFeatureProvider);

    void refresh() => ref.read(appRefreshProvider.notifier).refresh();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts & Wallets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () async {
              final ok = await showTransferDialog(context, accounts, repo.transfer);
              if (ok == true) refresh();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ok = await showAccountDialog(context, repo.accounts);
          if (ok == true) refresh();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: accounts.length,
        itemBuilder: (context, i) {
          final account = accounts[i];
          return AccountTile(
            account: account,
            currencySymbol: settings.currencySymbol,
            onEdit: () async {
              final ok = await showAccountDialog(
                context,
                repo.accounts,
                existing: account,
              );
              if (ok == true) refresh();
            },
            onLongPress: () async {
              if (accounts.length <= 1) return;
              await repo.accounts.delete(account.id);
              refresh();
            },
          );
        },
      ),
    );
  }
}
