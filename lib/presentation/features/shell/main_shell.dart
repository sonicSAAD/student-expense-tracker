import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/presentation/features/shell/shell_destinations.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});
  final Widget child;

  static const _paths = [
    AppRoutes.home,
    AppRoutes.transactions,
    AppRoutes.analytics,
    AppRoutes.budgets,
    AppRoutes.settings,
  ];

  int _currentIndex(String location) {
    if (location.startsWith('/transactions')) return 1;
    if (location.startsWith('/analytics')) return 2;
    if (location.startsWith('/budgets')) return 3;
    if (location.startsWith('/settings')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(location),
        onDestinationSelected: (i) => context.go(_paths[i]),
        destinations: shellDestinations,
      ),
    );
  }
}
