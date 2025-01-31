import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/core/themes/colors.dart';
import 'package:financial_tracker/core/utils/is_dark_mode.dart';
import 'package:financial_tracker/features/categories/domain/models/category_model.dart';
import 'package:financial_tracker/features/categories/provider/categories_providers.dart';
import 'package:financial_tracker/features/settings/riverpod/app_theme_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(categoriesNotifierProvider);
    final selectedTheme = ref.watch(themeProvider).themeMode;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          title: Text(
            "Categories",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.newEditCategory);
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ],
        ),
        body: categoryState.categories.when(
          data: (categories) {
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Dismissible(
                    key: Key(category.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (context) => DeleteDialog(
                          selectedTheme: selectedTheme,
                          category: category,
                          ref: ref,
                        ),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.newEditCategory,
                            arguments: category);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 4, color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: category.color.withValues(alpha: 0.25),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                category.icon,
                                color: category.color,
                                size: 21,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              category.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text('errors: $error'),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.newEditCategory);
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
              ),
              child: const Text(
                "Create New",
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.selectedTheme,
    required this.category,
    required this.ref,
  });

  final ThemeMode selectedTheme;
  final Category category;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: isDarkMode(context, selectedTheme)
          ? AppColors.textPrimary.withValues(alpha: 0.8) // Gray for dark mode
          : null,
      title: Text("Delete ${category.name} category"),
      content:
          Text("Are you sure you want to delete ${category.name} category?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            ref
                .read(categoriesNotifierProvider.notifier)
                .deleteCategory(category);
            Navigator.of(context).pop();
          },
          child: const Text(
            "Delete",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.error,
            ),
          ),
        ),
      ],
    );
  }
}
