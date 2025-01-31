import 'package:financial_tracker/features/categories/domain/models/category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesState {
  final AsyncValue<List<Category>> categories;

  CategoriesState({required this.categories});

  CategoriesState copyWith({AsyncValue<List<Category>>? categories}) {
    return CategoriesState(categories: categories ?? this.categories);
  }
}
