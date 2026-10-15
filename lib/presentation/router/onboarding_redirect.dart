import 'package:student_expense_tracker/presentation/router/app_routes.dart';

/// Decides where a navigation should land while onboarding is a gate.
///
/// Returns the location to redirect to, or null to let the request through.
String? onboardingRedirect({
  required bool onboardingCompleted,
  required String location,
}) {
  final isOnboarding = location == AppRoutes.onboarding;
  if (!onboardingCompleted) {
    return isOnboarding ? null : AppRoutes.onboarding;
  }
  return isOnboarding ? AppRoutes.home : null;
}
