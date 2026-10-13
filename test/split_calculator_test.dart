import 'package:flutter_test/flutter_test.dart';
import 'package:student_expense_tracker/domain/usecases/calculators.dart';

void main() {
  group('SplitCalculator', () {
    test('splits amount equally', () {
      final splits = SplitCalculator.equalSplit(100, 4);
      expect(splits.length, 4);
      expect(splits.every((a) => a == 25), true);
    });

    test('detects fully settled participants', () {
      expect(SplitCalculator.isFullySettled([true, true, true]), true);
      expect(SplitCalculator.isFullySettled([true, false]), false);
    });

    test('calculates total owed', () {
      expect(
        SplitCalculator.totalOwed([50, 30, 20], [false, true, false]),
        70,
      );
    });
  });
}
