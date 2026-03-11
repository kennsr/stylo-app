import 'package:flutter/material.dart';
import 'app_colors.dart';

extension ThemeContextExt on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  Color get surfaceColor =>
      isDarkMode ? AppColors.darkSurface : AppColors.lightSurface;
  Color get backgroundColor =>
      isDarkMode ? AppColors.darkBackground : AppColors.lightBackground;
  Color get primaryTextColor =>
      isDarkMode ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;
  Color get secondaryTextColor =>
      isDarkMode ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
  Color get dividerColor =>
      isDarkMode ? AppColors.darkDivider : AppColors.lightDivider;
  Color get borderColor =>
      isDarkMode ? AppColors.darkBorder : AppColors.lightBorder;
}
