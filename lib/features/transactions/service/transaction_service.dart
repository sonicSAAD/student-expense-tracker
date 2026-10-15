import 'package:student_expense_tracker/core/services/box_io.dart';
import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/data/mappers/entity_mappers.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:uuid/uuid.dart';

class TransactionService {
  TransactionService({required HiveService hive, Uuid? uuid}) : _hive = hive;

  final HiveService _hive;

  BoxIo get _box => BoxIo(_hive.transactionsBox());

  List<Transaction> getAll() =>
      _box.readAll(EntityMappers.transactionFromMap)
        ..sort((a, b) => b.date.compareTo(a.date));

  List<Transaction> getPage(int page, int pageSize) {
    final all = getAll();
    final start = page * pageSize;
    if (start >= all.length) return [];
    final end = start + pageSize;
    return all.sublist(start, end > all.length ? all.length : end);
  }

  Transaction? findById(String id) =>
      _box.readById(id, EntityMappers.transactionFromMap);

  Future<void> add(Transaction transaction) =>
      _box.put(transaction.id, EntityMappers.transactionToMap(transaction));

  Future<void> update(Transaction oldTx, Transaction newTx) =>
      _box.put(newTx.id, EntityMappers.transactionToMap(newTx));

  Future<void> delete(String id) => _box.remove(id);
}
