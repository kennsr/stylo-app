import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences prefs;

  ThemeCubit(this.prefs) : super(ThemeMode.system);

  void loadSavedTheme() {
    final saved = prefs.getString(AppConstants.themeKey);
    if (saved == 'light') {
      emit(ThemeMode.light);
    } else if (saved == 'dark') {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.system);
    }
  }

  void setTheme(ThemeMode mode) {
    emit(mode);
    _save(mode);
  }

  void toggleTheme() {
    final next =
        state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setTheme(next);
  }

  void _save(ThemeMode mode) {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    prefs.setString(AppConstants.themeKey, value);
  }
}
