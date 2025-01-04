import 'package:financial_tracker/core/routes/routes.dart';
import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/core/themes/theme.dart';
import 'package:financial_tracker/core/themes/colors.dart';
import 'package:financial_tracker/features/wish_list/presentation/wishlist_screen.dart';
import 'package:financial_tracker/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRoutes.generateRoute,
      home: const MyHomePage(title: "title"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _screenOptions = [
    const HomeScreen(),
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
                  children: [Icon(Icons.add), Text("New Transaction")],
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
              icon: Icon(Icons.shopping_basket, color: AppColors.textSecondary),
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
