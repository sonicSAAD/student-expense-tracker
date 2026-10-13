import 'package:csv/csv.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:student_expense_tracker/core/utils/date_utils.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';

class AnalyticsExporter {
  static Future<void> exportCsv({
    required List<Transaction> transactions,
    required List<Category> categories,
  }) async {
    final rows = <List<dynamic>>[
      ['Date', 'Type', 'Category', 'Amount', 'Note'],
    ];
    for (final t in transactions) {
      final cat = categories.where((c) => c.id == t.categoryId).firstOrNull;
      rows.add([
        AppDateUtils.formatDate(t.date),
        t.type.name,
        cat?.name ?? 'Unknown',
        t.amount,
        t.note,
      ]);
    }
    final csv = const ListToCsvConverter().convert(rows);
    await SharePlus.instance.share(ShareParams(text: csv, subject: 'Expense Report'));
  }

  static Future<void> exportPdf({
    required String currencySymbol,
    required double totalSpent,
    required Map<String, double> categorySpending,
    required List<Category> categories,
  }) async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Expense Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text('Total spent: $currencySymbol${totalSpent.toStringAsFixed(2)}'),
            pw.SizedBox(height: 16),
            pw.Text('Categories', style: const pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 8),
            for (final e in categorySpending.entries)
              pw.Text('${categories.where((c) => c.id == e.key).firstOrNull?.name ?? "Other"}: $currencySymbol${e.value.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
    await Printing.layoutPdf(onLayout: (_) async => doc.save());
  }
}
