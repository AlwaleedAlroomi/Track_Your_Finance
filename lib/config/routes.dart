import 'package:financial_tracker/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracker/features/accounts/presentaion/account_screen.dart';
import 'package:financial_tracker/features/accounts/presentaion/add_edit_account.dart';
import 'package:financial_tracker/features/categories/domain/models/category_model.dart';
import 'package:financial_tracker/features/categories/presentation/add_edit_category.dart';
import 'package:financial_tracker/features/categories/presentation/categories_screen.dart';
import 'package:financial_tracker/features/settings/settings_screen.dart';
import 'package:financial_tracker/screens/home_screen.dart';
import 'package:financial_tracker/screens/transaction_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String transaction = '/transaction';
  static const String categories = '/categories';
  static const String newEditCategory = '/addEditCategory';
  static const String setting = '/settings';
  static const String showAccount = '/showAccount';
  static const String addEditAccount = '/addEditAccount';

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
      case setting:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case showAccount:
        final account = settings.arguments as Account;
        return MaterialPageRoute(
            builder: (_) => AccountScreen(account: account));
      case addEditAccount:
        final accountToEdit = settings.arguments as Account?;
        return MaterialPageRoute(
            builder: (_) => AddEditAccount(account: accountToEdit));

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
