import 'package:equatable/equatable.dart';

class SplitParticipant extends Equatable {
  const SplitParticipant({
    required this.name,
    required this.amount,
    this.hasPaid = false,
  });

  final String name;
  final double amount;
  final bool hasPaid;

  SplitParticipant copyWith({String? name, double? amount, bool? hasPaid}) {
    return SplitParticipant(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      hasPaid: hasPaid ?? this.hasPaid,
    );
  }

  @override
  List<Object?> get props => [name, amount, hasPaid];
}
