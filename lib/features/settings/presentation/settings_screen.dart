import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/features/settings/presentation/widgets/setting_option.dart';
import 'package:financial_tracker/features/settings/riverpod/app_theme_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  final List<ThemeMode> _themeslist = [
    ThemeMode.dark,
    ThemeMode.light,
    ThemeMode.system
  ];

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider).themeMode;
    final themeNotifier = ref.read(themeProvider.notifier);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings",
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SettingOptions(
              optionName: "App Theme",
              optionIcon: const Icon(Icons.close),
              child: DropdownButton<ThemeMode>(

                value: selectedTheme,
                onChanged: (newTheme) {
                  themeNotifier.saveTheme(newTheme!);
                },
                items: _themeslist
                    .map<DropdownMenuItem<ThemeMode>>((ThemeMode theme) {
                  return DropdownMenuItem(
                    value: theme,
                    child: Text(theme.toString().split('.').last),
                  );
                }).toList(),
              ),
            ),
            SettingOptions(
              optionName: "Face ID",
              optionIcon: const Icon(Icons.money),
              showSwitch: true,
              onSwitchChanged: (value) {},
            ),
            SettingOptions(
              optionName: "Categories",
              optionIcon: const Icon(Icons.grid_4x4_sharp),
              onTap: () => Navigator.pushNamed(context, RouteNames.categories),
            ),
          ],
        ),
      ),
    );
  }
}
