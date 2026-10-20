import 'package:flutter_test/flutter_test.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/features/accounts/service/transfer_transactions.dart';

Category _cat(String name) =>
    Category(id: name, name: name, icon: 'receipt_long', color: 0xFF1A1A1A);

void main() {
  group('transferCategory', () {
    test('prefers the Other category over the first one', () {
      final picked = transferCategory([_cat('Food'), _cat('Other')]);
      expect(picked?.name, 'Other');
    });

    test('falls back to the first category when Other is absent', () {
      final picked = transferCategory([_cat('Food'), _cat('Transport')]);
      expect(picked?.name, 'Food');
    });

    test('returns null when there are no categories', () {
      expect(transferCategory([]), isNull);
    });
  });
}
