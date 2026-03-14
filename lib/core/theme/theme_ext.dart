import 'package:flutter/material.dart';
import 'app_colors.dart';

extension ThemeContextExt on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  
  // Surface colors
  Color get surfaceColor =>
      isDarkMode ? AppColors.darkSurface : AppColors.lightSurface;
  Color get surfaceHighColor =>
      isDarkMode ? AppColors.darkSurfaceHigh : AppColors.lightSurfaceHigh;
  Color get surfaceElevatedColor =>
      isDarkMode ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated;
  
  // Background
  Color get backgroundColor =>
      isDarkMode ? AppColors.darkBackground : AppColors.lightBackground;
  
  // Text colors
  Color get primaryTextColor =>
      isDarkMode ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;
  Color get secondaryTextColor =>
      isDarkMode ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
  Color get tertiaryTextColor =>
      isDarkMode ? AppColors.darkTertiaryText : AppColors.lightTertiaryText;
  
  // Divider and border
  Color get dividerColor =>
      isDarkMode ? AppColors.darkDivider : AppColors.lightDivider;
  Color get borderColor =>
      isDarkMode ? AppColors.darkBorder : AppColors.lightBorder;
  
  // Shadow
  Color get shadowColor =>
      isDarkMode ? AppColors.darkShadow : AppColors.lightShadow;
  
  // Status colors
  Color get successColor => AppColors.success;
  Color get errorColor => AppColors.error;
  Color get warningColor => AppColors.warning;
  Color get infoColor => AppColors.info;
  
  // Brand
  Color get primaryColor => AppColors.primary;
  Color get primaryLightColor => AppColors.primaryLight;
  Color get primarySubtleColor => AppColors.primarySubtle;
}
