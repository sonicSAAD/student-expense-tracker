import 'package:flutter/material.dart';

IconData iconFromName(String name) {
  const map = {
    'restaurant': Icons.restaurant,
    'directions_bus': Icons.directions_bus,
    'movie': Icons.movie,
    'school': Icons.school,
    'shopping_bag': Icons.shopping_bag,
    'medical_services': Icons.medical_services,
    'receipt_long': Icons.receipt_long,
    'more_horiz': Icons.more_horiz,
    'payments': Icons.payments,
    'account_balance': Icons.account_balance,
    'credit_card': Icons.credit_card,
    'phone_android': Icons.phone_android,
    'savings': Icons.savings,
    'wallet': Icons.wallet,
    'home': Icons.home,
    'fitness_center': Icons.fitness_center,
    'subscriptions': Icons.subscriptions,
  };
  return map[name] ?? Icons.category;
}
