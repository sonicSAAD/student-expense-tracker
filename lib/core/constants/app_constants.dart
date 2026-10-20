class AppConstants {
  static const String appName = 'Student Expense Tracker';

  static const String boxTransactions = 'transactions';
  static const String boxCategories = 'categories';
  static const String boxAccounts = 'accounts';
  static const String boxBudgets = 'budgets';
  static const String boxRecurringBills = 'recurring_bills';
  static const String boxSavingsGoals = 'savings_goals';
  static const String boxSplitExpenses = 'split_expenses';
  static const String boxSettings = 'settings';

  static const List<String> boxNames = [
    boxTransactions,
    boxCategories,
    boxAccounts,
    boxBudgets,
    boxRecurringBills,
    boxSavingsGoals,
    boxSplitExpenses,
    boxSettings,
  ];

  static const int budgetWarningThreshold = 80;
  static const int budgetExceededThreshold = 100;
  static const int defaultBillReminderDays = 2;

  static const List<Map<String, dynamic>> defaultCategories = [
    {'name': 'Food', 'icon': 'restaurant', 'color': 0xFF1A1A1A},
    {'name': 'Transport', 'icon': 'directions_bus', 'color': 0xFF3A3A3A},
    {'name': 'Entertainment', 'icon': 'movie', 'color': 0xFF5A5A5A},
    {'name': 'Education', 'icon': 'school', 'color': 0xFF3A3A3A},
    {'name': 'Shopping', 'icon': 'shopping_bag', 'color': 0xFF4A4A4A},
    {'name': 'Health', 'icon': 'medical_services', 'color': 0xFF3A3A3A},
    {'name': 'Bills', 'icon': 'receipt_long', 'color': 0xFF2A2A2A},
    {'name': 'Other', 'icon': 'more_horiz', 'color': 0xFF6A6A6A},
  ];

  static const List<Map<String, dynamic>> defaultAccounts = [
    {'name': 'Cash', 'icon': 'payments', 'balance': 0.0},
    {'name': 'Bank', 'icon': 'account_balance', 'balance': 0.0},
    {'name': 'Card', 'icon': 'credit_card', 'balance': 0.0},
    {'name': 'UPI', 'icon': 'phone_android', 'balance': 0.0},
  ];

  static const List<Map<String, String>> supportedCurrencies = [
    {'code': 'USD', 'symbol': '\$', 'name': 'US Dollar'},
    {'code': 'EUR', 'symbol': '€', 'name': 'Euro'},
    {'code': 'GBP', 'symbol': '£', 'name': 'British Pound'},
    {'code': 'INR', 'symbol': '₹', 'name': 'Indian Rupee'},
    {'code': 'JPY', 'symbol': '¥', 'name': 'Japanese Yen'},
    {'code': 'CAD', 'symbol': 'C\$', 'name': 'Canadian Dollar'},
    {'code': 'AUD', 'symbol': 'A\$', 'name': 'Australian Dollar'},
  ];
}
