import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/core/constants/app_constants.dart';
import 'package:student_expense_tracker/domain/entities/app_settings.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';

Future<void> showCurrencyPicker(BuildContext context, WidgetRef ref, AppSettings s) async {
  final repo = ref.read(appFeatureProvider);
  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Select Currency'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: AppConstants.supportedCurrencies
              .map((c) => ListTile(
                    title: Text(c['name']!),
                    trailing: Text(c['symbol']!),
                    onTap: () async {
                      await repo.settings.save(s.copyWith(currencyCode: c['code'], currencySymbol: c['symbol']));
                      ref.read(appRefreshProvider.notifier).refresh();
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                  ))
              .toList(),
        ),
      ),
    ),
  );
}

Future<void> showThemePicker(BuildContext context, WidgetRef ref, AppSettings s) async {
  final repo = ref.read(appFeatureProvider);
  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Select Theme'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: ThemePreference.values
            .map((t) => ListTile(
                  title: Text(t.name),
                  onTap: () async {
                    await repo.settings.save(s.copyWith(themePreference: t));
                    ref.read(appRefreshProvider.notifier).refresh();
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                ))
            .toList(),
      ),
    ),
  );
}
