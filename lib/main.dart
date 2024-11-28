import 'package:financial_tracker/config/routes.dart';
import 'package:financial_tracker/config/theme.dart';
import 'package:financial_tracker/core/constants/colors.dart';
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
      // initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
      home: MyHomePage(title: "title"),
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
    const TransactionScreen()
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.transaction);
          },
          tooltip: 'New Transaction',
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: ('Category'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: ('Setting'),
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
