import 'package:financial_tracker/core/themes/colors.dart';
import 'package:flutter/material.dart';

class SettingOptions extends StatelessWidget {
  final String optionName;
  final Icon optionIcon;
  final bool showSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final GestureTapCallback? onTap;
  final Widget? child;

const SettingOptions({
    super.key,
    required this.optionName,
    required this.optionIcon,
    this.onSwitchChanged,
    this.onTap,
    this.showSwitch = false,
    this.switchValue = false,
    this.child,
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
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}
