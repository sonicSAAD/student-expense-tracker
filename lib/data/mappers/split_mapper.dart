import 'package:student_expense_tracker/domain/entities/split_expense.dart';

class SplitMapper {
  static Map<String, dynamic> toMap(SplitExpense s) => {
        'id': s.id,
        'title': s.title,
        'totalAmount': s.totalAmount,
        'participants': s.participants
            .map((p) => {
                  'name': p.name,
                  'amount': p.amount,
                  'hasPaid': p.hasPaid,
                })
            .toList(),
        'isSettled': s.isSettled,
        'date': s.date.toIso8601String(),
        'note': s.note,
      };

  static SplitExpense fromMap(Map map) => SplitExpense(
        id: map['id'] as String,
        title: map['title'] as String,
        totalAmount: (map['totalAmount'] as num).toDouble(),
        participants: (map['participants'] as List)
            .map((p) => SplitParticipant(
                  name: p['name'] as String,
                  amount: (p['amount'] as num).toDouble(),
                  hasPaid: p['hasPaid'] as bool? ?? false,
                ))
            .toList(),
        isSettled: map['isSettled'] as bool? ?? false,
        date: DateTime.parse(map['date'] as String),
        note: map['note'] as String?,
      );
}
