import 'package:financial_tracker/config/routes.dart';
import 'package:financial_tracker/core/constants/colors.dart';
import 'package:financial_tracker/features/categories/domain/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<Category> _categories = [
    Category(
      id: 1,
      name: "name",
      color: Colors.yellow,
      icon: const Icon(Icons.sports_basketball),
    ),
    Category(
      id: 2,
      name: "second",
      color: Colors.red,
      icon: const Icon(Icons.deblur),
    ),
    Category(
      id: 3,
      name: "third",
      color: Colors.orange,
      icon: const Icon(Icons.delete),
    ),
    Category(
      id: 4,
      name: "hello",
      color: Colors.blue,
      icon: const Icon(Icons.read_more),
    ),
    Category(
      id: 5,
      name: "test",
      color: Colors.lime,
      icon: const Icon(Icons.wallet),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   AppRoutes.home,
              //   (route) => false,
              // );
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          title: const Text(
            "Categories",
            style: TextStyle(color: AppColors.textPrimary),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.newEditCategory);
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.newEditCategory,
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
                          color: category.color.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          category.icon.icon,
                          color: category.color,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.newEditCategory);
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
              ),
              child: const Text(
                "Create New",
                style: TextStyle(color: AppColors.textAccent),
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
