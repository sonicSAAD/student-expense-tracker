import 'package:flutter/material.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

const defaultOnboardingPages = [
  OnboardingPageData(
    icon: Icons.account_balance_wallet,
    title: 'Track Your Spending',
    description: 'Log every expense and income to understand where your money goes each month.',
  ),
  OnboardingPageData(
    icon: Icons.pie_chart,
    title: 'Set Smart Budgets',
    description: 'Create monthly budgets per category and get alerts before you overspend.',
  ),
  OnboardingPageData(
    icon: Icons.savings,
    title: 'Hit Savings Goals',
    description: 'Set targets for laptops, trips, or emergencies and watch your progress grow.',
  ),
];
