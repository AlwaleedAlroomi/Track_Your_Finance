import 'package:financial_tracker/config/routes.dart';
import 'package:financial_tracker/config/theme.dart';
import 'package:financial_tracker/core/constants/colors.dart';
import 'package:financial_tracker/features/categories/presentation/categories_screen.dart';
import 'package:financial_tracker/features/settings/settings_screen.dart';
import 'package:financial_tracker/screens/home_screen.dart';
import 'package:financial_tracker/screens/transaction_screen.dart';
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
    const TransactionScreen(),
    const CategoriesScreen(),
    const SettingsScreen(),
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
                  Navigator.pushNamed(context, AppRoutes.transaction);
                },
                tooltip: 'New Transaction',
                label: const Row(
                  children: [Icon(Icons.add), Text("New Transaction")],
                ),
              )
            : null,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        bottomNavigationBar: _selectedIndex == 0 || _selectedIndex == 3
            ? BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: AppColors.textSecondary,
                    ),
                    label: ('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.transfer_within_a_station_outlined,
                        color: AppColors.textSecondary),
                    label: ('transaction'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category, color: AppColors.textSecondary),
                    label: ('Category'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings, color: AppColors.textSecondary),
                    label: ('Setting'),
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: AppColors.primary,
                onTap: _onItemTapped,
              )
            : null,
      ),
    );
  }
}
