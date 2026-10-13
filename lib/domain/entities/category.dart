import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.monthlyBudgetLimit = 0,
  });

  final String id;
  final String name;
  final String icon;
  final int color;
  final double monthlyBudgetLimit;

  @override
  List<Object?> get props => [id, name, icon, color, monthlyBudgetLimit];
}
