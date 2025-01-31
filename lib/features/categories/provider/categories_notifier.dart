import 'package:financial_tracker/features/categories/data/categories_repository.dart';
import 'package:financial_tracker/features/categories/domain/models/category_model.dart';
import 'package:financial_tracker/features/categories/provider/categories_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final CategoriesRepository _repository;

  CategoriesNotifier(this._repository)
      : super(CategoriesState(categories: const AsyncValue.loading())) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = state.copyWith(categories: const AsyncValue.loading());
    try {
      final categories = await _repository.getAllCategories();
      state = state.copyWith(categories: AsyncValue.data(categories));
    } catch (e, stackTrace) {
      state = state.copyWith(categories: AsyncValue.error(e, stackTrace));
    }
  }

  Future<void> addCategory(Category category) async {
    try {
      await _repository.addCategory(category);
      await loadCategories();
    } catch (e, stackTrace) {
      state = state.copyWith(categories: AsyncValue.error(e, stackTrace));
    }
  }

  Future<void> updateCategory(Category category) async {
    try {
      await _repository.updateCategory(category);
      await loadCategories();
    } catch (e, stackTrace) {
      state = state.copyWith(categories: AsyncValue.error(e, stackTrace));
    }
  }

  Future<void> deleteCategory(Category category) async {
    try {
      await _repository.deleteCategory(category);
      await loadCategories();
    } catch (e, stackTrace) {
      state = state.copyWith(categories: AsyncValue.error(e, stackTrace));
    }
  }
}
