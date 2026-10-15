import 'package:flutter/material.dart';

/// The free-text inputs of the add/edit transaction form.
class AddTransactionTextInputs extends StatelessWidget {
  const AddTransactionTextInputs({
    super.key,
    required this.amount,
    required this.note,
    required this.currencySymbol,
  });

  final TextEditingController amount;
  final TextEditingController note;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: amount,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Amount',
            prefixText: '$currencySymbol ',
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: note,
          decoration: const InputDecoration(labelText: 'Note'),
        ),
      ],
    );
  }
}
