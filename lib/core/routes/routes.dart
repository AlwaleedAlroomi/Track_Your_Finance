import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracker/features/accounts/presentation/account_screen.dart';
import 'package:financial_tracker/features/accounts/presentation/add_edit_account.dart';
import 'package:financial_tracker/features/categories/domain/models/category_model.dart';
import 'package:financial_tracker/features/categories/presentation/add_edit_category.dart';
import 'package:financial_tracker/features/categories/presentation/categories_screen.dart';
import 'package:financial_tracker/features/home/presentation/home_screen.dart';
import 'package:financial_tracker/features/settings/presentation/settings_screen.dart';
import 'package:financial_tracker/features/transaction/presentation/transaction_screen.dart';
import 'package:financial_tracker/features/wish_list/presentation/add_edit_wish.dart';
import 'package:financial_tracker/features/wish_list/presentation/choose_image.dart';
import 'package:financial_tracker/features/wish_list/presentation/show_item.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteNames.transaction:
        return MaterialPageRoute(builder: (_) => const TransactionScreen());
      case RouteNames.categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case RouteNames.newEditCategory:
        final category = settings.arguments as Category?;
        return MaterialPageRoute(
            builder: (_) => AddEditCategoryScreen(category: category));
      case RouteNames.setting:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case RouteNames.showAccount:
        final account = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => AccountScreen(accountId: account));
      case RouteNames.addEditAccount:
        final accountToEdit = settings.arguments as Account?;
        return MaterialPageRoute(
            builder: (_) => AddEditAccount(account: accountToEdit));
      case RouteNames.addEditWish:
        final wishToEdit = settings.arguments as int?;
        return MaterialPageRoute(
            builder: (_) => AddEditWish(wishlistItemId: wishToEdit));
      case RouteNames.imagePicker:
        return MaterialPageRoute(builder: (_) => const ImagePicker());
      case RouteNames.showWish:
        final wishItem = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => ShowWishItem(wishListItemId: wishItem));

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
