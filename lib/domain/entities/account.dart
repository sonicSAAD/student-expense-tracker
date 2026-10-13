import 'package:equatable/equatable.dart';

class Account extends Equatable {
  const Account({
    required this.id,
    required this.name,
    required this.icon,
    required this.balance,
  });

  final String id;
  final String name;
  final String icon;
  final double balance;

  @override
  List<Object?> get props => [id, name, icon, balance];
}
