import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double amount, String symbol) {
    final formatter = NumberFormat('#,##0.##');
    return '$symbol${formatter.format(amount)}';
  }

}
