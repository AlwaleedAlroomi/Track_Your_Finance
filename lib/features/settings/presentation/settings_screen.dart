// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:financial_tracker/core/routes/routes_name.dart';
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
            _settingOptions(
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
            _settingOptions(
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
            _settingOptions(
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

// ignore: camel_case_types
class _settingOptions extends StatelessWidget {
  final String optionName;
  final Icon optionIcon;
  final bool showSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final GestureTapCallback? onTap;

  const _settingOptions({
    required this.optionName,
    required this.optionIcon,
    this.onSwitchChanged,
    this.onTap,
    this.showSwitch = false,
    this.switchValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: optionIcon,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  optionName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              if (showSwitch)
                Switch(
                  value: switchValue,
                  onChanged: onSwitchChanged,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
