import 'package:financial_tracker/core/routes/routes.dart';
import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/core/themes/theme.dart';
import 'package:financial_tracker/core/themes/colors.dart';
import 'package:financial_tracker/features/settings/riverpod/app_theme_riverpod.dart';
import 'package:financial_tracker/features/wish_list/presentation/wishlist_screen.dart';
import 'package:financial_tracker/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider).themeMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: theme,
      onGenerateRoute: AppRoutes.generateRoute,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _screenOptions = [
    HomeScreen(),
    const WishlistScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screenOptions.elementAt(_selectedIndex),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.transaction);
                },
                tooltip: 'New Transaction',
                label: const Row(
                  children: [
                    Icon(Icons.add),
                    Text("New Transaction"),
                  ],
                ),
              )
            : null,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: AppColors.textSecondary,
              ),
              label: ('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_basket,
                color: AppColors.textSecondary,
              ),
              label: ('Wish List'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.primary,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
