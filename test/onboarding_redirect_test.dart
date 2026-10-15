import 'package:flutter_test/flutter_test.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';
import 'package:student_expense_tracker/presentation/router/onboarding_redirect.dart';

void main() {
  group('onboardingRedirect', () {
    test('sends the first launch to onboarding', () {
      expect(
        onboardingRedirect(onboardingCompleted: false, location: AppRoutes.home),
        AppRoutes.onboarding,
      );
      expect(
        onboardingRedirect(
          onboardingCompleted: false,
          location: AppRoutes.transactions,
        ),
        AppRoutes.onboarding,
      );
    });

    test('keeps onboarding reachable while it is incomplete', () {
      expect(
        onboardingRedirect(
          onboardingCompleted: false,
          location: AppRoutes.onboarding,
        ),
        isNull,
      );
    });

    test('lets the app through once onboarding is completed', () {
      expect(
        onboardingRedirect(onboardingCompleted: true, location: AppRoutes.home),
        isNull,
      );
      expect(
        onboardingRedirect(
          onboardingCompleted: true,
          location: AppRoutes.analytics,
        ),
        isNull,
      );
    });

    test('leaves onboarding behind once it is completed', () {
      expect(
        onboardingRedirect(
          onboardingCompleted: true,
          location: AppRoutes.onboarding,
        ),
        AppRoutes.home,
      );
    });
  });
}
