import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/data/mappers/entity_mappers.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';

class CategoryService {
  CategoryService({required HiveService hive}) : _hive = hive;

  final HiveService _hive;

  List<Category> getAll() {
    try {
      return _hive.getAllFromBox(_hive.categoriesBox())
          .map(EntityMappers.categoryFromMap)
          .toList();
    } catch (_) {
      return [];
    }
  }

  Category? findById(String id) {
    try {
      final map = _hive.categoriesBox().get(id);
      if (map == null) return null;
      return EntityMappers.categoryFromMap(
        Map<String, dynamic>.from(map as Map),
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> update(Category category) async {
    try {
      await _hive.putInBox(
        _hive.categoriesBox(),
        category.id,
        EntityMappers.categoryToMap(category),
      );
    } catch (_) {}
  }
}
