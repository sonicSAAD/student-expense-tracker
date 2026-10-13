import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';

class OnboardingSetupStep extends ConsumerWidget {
  const OnboardingSetupStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 64),
          const SizedBox(height: 24),
          Text(
            'You are All Set!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Start managing your budget, tracking bills, and saving money effortlessly.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),
          FilledButton(
            onPressed: () async {
              final repo = ref.read(appFeatureProvider);
              final s = ref.read(settingsProvider);
              await repo.settings.save(s.copyWith(onboardingCompleted: true));
              ref.read(appRefreshProvider.notifier).refresh();
              if (context.mounted) context.go(AppRoutes.home);
            },
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}
