import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/presentation/features/onboarding/screen/onboarding_screen.dart';
import 'package:student_expense_tracker/presentation/features/shell/main_shell.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';
import 'package:student_expense_tracker/presentation/router/feature_routes.dart';

export 'package:student_expense_tracker/presentation/router/feature_routes.dart';

final goRouterProvider = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: appShellRoutes(),
    ),
  ],
  redirect: (context, state) {
    final isOnboarding = state.matchedLocation == AppRoutes.onboarding;
    if (!isOnboarding) {
      return AppRoutes.onboarding;
    }
    return null;
  },
);
