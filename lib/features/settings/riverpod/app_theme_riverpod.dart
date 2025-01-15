import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState {
  final ThemeMode themeMode;

  ThemeState({required this.themeMode});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(ThemeState(themeMode: ThemeMode.system)) {
    _loadTheme();
  }

  static const String _themeKey = 'selected_theme';

  // Save Theme Func
  Future<void> saveTheme(ThemeMode themeMode) async {
    if (state.themeMode == themeMode) return;

    state = state.copyWith(themeMode: themeMode);

    // Save to shared pref
    final themePrefs = await SharedPreferences.getInstance();
    await themePrefs.setString(_themeKey, themeMode.toString());
  }

  // Load Theme Func
  Future<void> _loadTheme() async {
    try {
      final themePrefs = await SharedPreferences.getInstance();
      final loadedTheme = themePrefs.getString(_themeKey);

      if (loadedTheme != null) {
        final themeMode = _themeModeStringFormatter(loadedTheme);
        state = state.copyWith(themeMode: themeMode);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ThemeMode _themeModeStringFormatter(String themeMode) {
    switch (themeMode) {
      case "ThemeMode.light":
        return ThemeMode.light;
      case "ThemeMode.dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (ref) => ThemeNotifier(),
);
