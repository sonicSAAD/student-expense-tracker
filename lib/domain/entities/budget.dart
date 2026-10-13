import 'package:equatable/equatable.dart';

class Budget extends Equatable {
  const Budget({
    required this.categoryId,
    required this.month,
    required this.limitAmount,
    this.spentAmount = 0,
  });

  final String categoryId;
  final String month;
  final double limitAmount;
  final double spentAmount;

  double get percentage =>
      limitAmount > 0 ? (spentAmount / limitAmount) * 100 : 0;

  @override
  List<Object?> get props => [categoryId, month, limitAmount, spentAmount];
}
