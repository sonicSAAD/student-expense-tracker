import 'package:equatable/equatable.dart';
import 'package:student_expense_tracker/domain/entities/split_participant.dart';

export 'package:student_expense_tracker/domain/entities/split_participant.dart';

class SplitExpense extends Equatable {
  const SplitExpense({
    required this.id,
    required this.title,
    required this.totalAmount,
    required this.participants,
    this.isSettled = false,
    required this.date,
    this.note,
  });

  final String id;
  final String title;
  final double totalAmount;
  final List<SplitParticipant> participants;
  final bool isSettled;
  final DateTime date;
  final String? note;

  SplitExpense copyWith({
    String? id,
    String? title,
    double? totalAmount,
    List<SplitParticipant>? participants,
    bool? isSettled,
    DateTime? date,
    String? note,
  }) {
    return SplitExpense(
      id: id ?? this.id,
      title: title ?? this.title,
      totalAmount: totalAmount ?? this.totalAmount,
      participants: participants ?? this.participants,
      isSettled: isSettled ?? this.isSettled,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, totalAmount, participants, isSettled, date, note];
}
