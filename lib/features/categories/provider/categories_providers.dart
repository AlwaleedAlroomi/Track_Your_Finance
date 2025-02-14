import 'package:financial_tracker/features/categories/data/categories_repository.dart';
import 'package:financial_tracker/features/categories/provider/categories_notifier.dart';
import 'package:financial_tracker/features/categories/provider/categories_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../accounts/provider/accounts_providers.dart';

final categoriesRepositoryProvider = Provider((ref) {
  final databaseHelper = ref.watch(databaseHelperProvider);
  return CategoriesRepository(databaseHelper);
});

final categoriesNotifierProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) {
  final categoriesRepository = ref.watch(categoriesRepositoryProvider);
  return CategoriesNotifier(categoriesRepository);
});
