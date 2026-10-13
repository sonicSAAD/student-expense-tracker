import 'package:flutter/material.dart';
import 'package:student_expense_tracker/presentation/features/onboarding/screen/onboarding_page_data.dart';
import 'package:student_expense_tracker/presentation/features/onboarding/screen/onboarding_page_widget.dart';
import 'package:student_expense_tracker/presentation/features/onboarding/screen/onboarding_setup_step.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  for (final item in defaultOnboardingPages)
                    OnboardingPageWidget(data: item),
                  const OnboardingSetupStep(),
                ],
              ),
            ),
            if (_page < defaultOnboardingPages.length)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => _controller.jumpToPage(defaultOnboardingPages.length),
                      child: const Text('Skip'),
                    ),
                    FilledButton(
                      onPressed: () => _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
