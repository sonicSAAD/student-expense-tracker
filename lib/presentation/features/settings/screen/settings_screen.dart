import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/presentation/features/settings/screen/settings_data_section.dart';
import 'package:student_expense_tracker/presentation/features/settings/screen/settings_dialogs.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';

export 'package:student_expense_tracker/presentation/features/settings/screen/app_lock_gate.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(settingsProvider);
    final repo = ref.watch(appFeatureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Preferences', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Currency'),
            subtitle: Text('${s.currencySymbol} ${s.currencyCode}'),
            onTap: () => showCurrencyPicker(context, ref, s),
          ),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Theme'),
            subtitle: Text(s.themePreference.name),
            onTap: () => showThemePicker(context, ref, s),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Notifications'),
            value: s.notificationsEnabled,
            onChanged: (v) async {
              await repo.settings.save(s.copyWith(notificationsEnabled: v));
              ref.read(appRefreshProvider.notifier).refresh();
            },
          ),
          const Divider(),
          SettingsDataSection(settings: s),
        ],
      ),
    );
  }
}
