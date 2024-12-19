import 'package:financial_tracker/features/categories/domain/models/category_model.dart';
import 'package:financial_tracker/features/categories/presentation/add_edit_category.dart';
import 'package:financial_tracker/features/categories/presentation/categories_screen.dart';
import 'package:financial_tracker/screens/home_screen.dart';
import 'package:financial_tracker/screens/transaction_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String transaction = '/transaction';
  static const String categories = '/categories';
  static const String newEditCategory = '/addEditCategory';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case transaction:
        return MaterialPageRoute(builder: (_) => const TransactionScreen());
      case categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case newEditCategory:
        final category = settings.arguments as Category?;
        return MaterialPageRoute(
            builder: (_) => AddEditCategoryScreen(category: category));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
