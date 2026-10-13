import 'package:equatable/equatable.dart';

class SavingsGoal extends Equatable {
  const SavingsGoal({
    required this.id,
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    this.deadline,
    this.icon = 'savings',
  });

  final String id;
  final String name;
  final double targetAmount;
  final double currentAmount;
  final DateTime? deadline;
  final String icon;

  double get percentage =>
      targetAmount > 0 ? (currentAmount / targetAmount) * 100 : 0;

  bool get isCompleted => currentAmount >= targetAmount;

  @override
  List<Object?> get props =>
      [id, name, targetAmount, currentAmount, deadline, icon];
}
