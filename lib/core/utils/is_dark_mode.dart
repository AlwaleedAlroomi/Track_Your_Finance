import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context, ThemeMode selectedTheme) {
  return selectedTheme == ThemeMode.dark ||
      (selectedTheme == ThemeMode.system &&
          MediaQuery.of(context).platformBrightness == Brightness.dark);
}
