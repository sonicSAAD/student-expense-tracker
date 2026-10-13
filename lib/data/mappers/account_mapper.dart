import 'package:student_expense_tracker/domain/entities/account.dart';

class AccountMapper {
  static Map<String, dynamic> toMap(Account a) => {
        'id': a.id,
        'name': a.name,
        'icon': a.icon,
        'balance': a.balance,
      };

  static Account fromMap(Map map) => Account(
        id: map['id'] as String,
        name: map['name'] as String,
        icon: map['icon'] as String,
        balance: (map['balance'] as num).toDouble(),
      );
}
