import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/domain/entities/app_settings.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';

class SettingsDataSection extends ConsumerWidget {
  const SettingsDataSection({super.key, required this.settings});
  final AppSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(appFeatureProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text('Data & Backup', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        ListTile(
          leading: const Icon(Icons.upload_outlined),
          title: const Text('Export Backup (JSON)'),
          onTap: () async => repo.backup.shareBackup(),
        ),
        ListTile(
          leading: const Icon(Icons.delete_forever_outlined),
          title: const Text('Delete All Data'),
          onTap: () async {
            final ok = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Delete All Data'),
                content: const Text('This will reset all your transactions and budgets.'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                  FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
                ],
              ),
            );
            if (ok == true) {
              await HiveService.instance.clearAllData();
              ref.read(appRefreshProvider.notifier).refresh();
            }
          },
        ),
      ],
    );
  }
}
