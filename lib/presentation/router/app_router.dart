import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/features/settings/service/settings_service.dart';
import 'package:student_expense_tracker/presentation/features/onboarding/screen/onboarding_screen.dart';
import 'package:student_expense_tracker/presentation/features/shell/main_shell.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';
import 'package:student_expense_tracker/presentation/router/feature_routes.dart';
import 'package:student_expense_tracker/presentation/router/onboarding_redirect.dart';

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
  // Onboarding is only a gate, not the whole app. Previously every other
  // location was redirected back here, so "Get Started" landed nowhere.
  redirect: (context, state) => onboardingRedirect(
    onboardingCompleted: SettingsService.isOnboardingCompleted,
    location: state.matchedLocation,
  ),
);
