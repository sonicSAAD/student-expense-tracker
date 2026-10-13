import 'package:student_expense_tracker/data/mappers/account_mapper.dart';
import 'package:student_expense_tracker/data/mappers/bill_mapper.dart';
import 'package:student_expense_tracker/data/mappers/budget_mapper.dart';
import 'package:student_expense_tracker/data/mappers/category_mapper.dart';
import 'package:student_expense_tracker/data/mappers/goal_mapper.dart';
import 'package:student_expense_tracker/data/mappers/settings_mapper.dart';
import 'package:student_expense_tracker/data/mappers/split_mapper.dart';
import 'package:student_expense_tracker/data/mappers/transaction_mapper.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/app_settings.dart';
import 'package:student_expense_tracker/domain/entities/budget.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:student_expense_tracker/domain/entities/savings_goal.dart';
import 'package:student_expense_tracker/domain/entities/split_expense.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';

export 'package:student_expense_tracker/data/mappers/account_mapper.dart';
export 'package:student_expense_tracker/data/mappers/bill_mapper.dart';
export 'package:student_expense_tracker/data/mappers/budget_mapper.dart';
export 'package:student_expense_tracker/data/mappers/category_mapper.dart';
export 'package:student_expense_tracker/data/mappers/goal_mapper.dart';
export 'package:student_expense_tracker/data/mappers/settings_mapper.dart';
export 'package:student_expense_tracker/data/mappers/split_mapper.dart';
export 'package:student_expense_tracker/data/mappers/transaction_mapper.dart';

class EntityMappers {
  static Map<String, dynamic> transactionToMap(Transaction t) =>
      TransactionMapper.toMap(t);
  static Transaction transactionFromMap(Map m) =>
      TransactionMapper.fromMap(m);

  static Map<String, dynamic> categoryToMap(Category c) =>
      CategoryMapper.toMap(c);
  static Category categoryFromMap(Map m) => CategoryMapper.fromMap(m);

  static Map<String, dynamic> accountToMap(Account a) => AccountMapper.toMap(a);
  static Account accountFromMap(Map m) => AccountMapper.fromMap(m);

  static Map<String, dynamic> budgetToMap(Budget b) => BudgetMapper.toMap(b);
  static Budget budgetFromMap(Map m) => BudgetMapper.fromMap(m);

  static Map<String, dynamic> recurringBillToMap(RecurringBill b) =>
      BillMapper.toMap(b);
  static RecurringBill recurringBillFromMap(Map m) => BillMapper.fromMap(m);

  static Map<String, dynamic> savingsGoalToMap(SavingsGoal g) =>
      GoalMapper.toMap(g);
  static SavingsGoal savingsGoalFromMap(Map m) => GoalMapper.fromMap(m);

  static Map<String, dynamic> splitExpenseToMap(SplitExpense s) =>
      SplitMapper.toMap(s);
  static SplitExpense splitExpenseFromMap(Map m) => SplitMapper.fromMap(m);

  static Map<String, dynamic> settingsToMap(AppSettings s) =>
      SettingsMapper.toMap(s);
  static AppSettings settingsFromMap(Map m) => SettingsMapper.fromMap(m);
}
