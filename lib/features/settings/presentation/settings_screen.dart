// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/features/settings/presentation/widgets/setting_option.dart';
import 'package:flutter/material.dart';

import 'package:financial_tracker/core/themes/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isFaceIDSwitched = false;
  bool isDarkModeSwitched = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings",
            style: TextStyle(color: AppColors.textPrimary),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SettingOptions(
              optionName: "Dark Mode",
              optionIcon: const Icon(Icons.close),
              showSwitch: true,
              switchValue: isDarkModeSwitched,
              onSwitchChanged: (value) {
                setState(() {
                  isDarkModeSwitched = value;
                });
              },
            ),
            SettingOptions(
              optionName: "Face ID",
              optionIcon: const Icon(Icons.money),
              switchValue: isFaceIDSwitched,
              showSwitch: true,
              onSwitchChanged: (value) {
                setState(() {
                  isFaceIDSwitched = value;
                });
              },
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
