import 'package:financial_tracker/core/themes/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.cardBackground,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textAccent,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    dividerColor: AppColors.divider,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.accent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      isDense: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      hintStyle: const TextStyle(color: AppColors.textSecondary),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildBorder(color: AppColors.primary),
      errorBorder: _buildBorder(color: AppColors.error),
      focusedErrorBorder: _buildBorder(color: AppColors.error),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      floatingLabelStyle: const TextStyle(color: AppColors.primary),
      errorStyle: const TextStyle(color: AppColors.error),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.primary),
        textStyle: WidgetStatePropertyAll<TextStyle>(
          TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    )),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,
    cardColor: const Color(0xFF1E1E1E), // Dark card background
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.textAccent,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textAccent,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    dividerColor: AppColors.divider,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.dark,
      secondary: AppColors.accent,
      surface: Colors.black,
    ),
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(Colors.white),
    )),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      isDense: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      hintStyle: const TextStyle(color: AppColors.textSecondary),
      enabledBorder: _buildBorder(color: AppColors.border),
      focusedBorder: _buildBorder(color: AppColors.primary),
      errorBorder: _buildBorder(color: AppColors.error),
      focusedErrorBorder: _buildBorder(color: AppColors.error),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      floatingLabelStyle: const TextStyle(color: AppColors.primary),
      errorStyle: const TextStyle(color: AppColors.error),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.primary),
        textStyle: WidgetStatePropertyAll<TextStyle>(
          TextStyle(
            color: AppColors.textAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );

  static OutlineInputBorder _buildBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color ?? AppColors.border,
        width: 1.5,
      ),
    );
  }
}
