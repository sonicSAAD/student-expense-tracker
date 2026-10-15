import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:student_expense_tracker/main.dart' as app;

/// Pumps repeatedly instead of using pumpAndSettle, because the app keeps
/// background animations running and pumpAndSettle would time out.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 12; i++) {
    await tester.pump(const Duration(milliseconds: 300));
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Get Started leaves onboarding and reaches the app shell', (
    tester,
  ) async {
    app.main();
    await _settle(tester);

    // A fresh install starts on onboarding.
    expect(find.text('Skip'), findsOneWidget);

    await tester.tap(find.text('Skip'));
    await _settle(tester);
    expect(find.text('Get Started'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await _settle(tester);

    // The bug: this used to bounce straight back to onboarding, so the app
    // shell was never reachable.
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('You are All Set!'), findsNothing);
    expect(find.text('Get Started'), findsNothing);

    // The shell destinations respond, so the app is usable.
    await tester.tap(find.text('Budgets'));
    await _settle(tester);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
