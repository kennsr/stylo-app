import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors - Electric Violet Collection
  static const Color primary = Color(0xFF6366F1); // Electric Violet
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primarySubtle = Color(0xFFEEF2FF);
  static const Color primaryGradientStart = Color(0xFF6366F1);
  static const Color primaryGradientEnd = Color(0xFF818CF8);
  
  // Backward compatibility alias
  static const Color accent = Color(0xFF6366F1); // Same as primary
  static const Color accentDark = Color(0xFF4F46E5);
  static const Color accentLight = Color(0xFF818CF8);
  
  // Secondary Color - Charcoal Black
  static const Color secondary = Color(0xFF1A1A1B); // Charcoal Black
  static const Color secondaryLight = Color(0xFF2D2D2E);
  
  // Success/Trust - Emerald Green
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  
  // Text Colors
  static const Color textBody = Color(0xFF475569); // Slate Gray
  static const Color textLabel = Color(0xFF94A3B8); // Light Gray
  
  // Status Colors
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  
  // Light Mode - Clean & Minimal
  static const Color lightBackground = Color(0xFFFFFFFF); // Pure White
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceHigh = Color(0xFFF9FAFB);
  static const Color lightSurfaceElevated = Color(0xFFFFFFFF);
  static const Color lightPrimaryText = Color(0xFF1A1A1B); // Charcoal Black
  static const Color lightSecondaryText = Color(0xFF475569); // Slate Gray
  static const Color lightTertiaryText = Color(0xFF94A3B8); // Light Gray
  static const Color lightDisabledText = Color(0xFFCBD5E1);
  static const Color lightDivider = Color(0xFFE2E8F0);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightShadow = Color(0x0A000000);
  
  // Dark Mode - True Dark
  static const Color darkBackground = Color(0xFF1A1A1B); // Charcoal Black
  static const Color darkSurface = Color(0xFF27272A);
  static const Color darkSurfaceHigh = Color(0xFF3F3F46);
  static const Color darkSurfaceElevated = Color(0xFF52525B);
  static const Color darkPrimaryText = Color(0xFFF1F5F9); // Light text for dark mode
  static const Color darkSecondaryText = Color(0xFF94A3B8); // Light Gray
  static const Color darkTertiaryText = Color(0xFF64748B);
  static const Color darkDisabledText = Color(0xFF475569);
  static const Color darkDivider = Color(0xFF334155);
  static const Color darkBorder = Color(0xFF475569);
  static const Color darkShadow = Color(0x1A000000);
  
  // Stars
  static const Color starFilled = Color(0xFFF59E0B);
  static const Color starEmpty = Color(0xFFD1D5DB);
  
  // Shimmer
  static const Color shimmerBase = Color(0xFFE2E8F0);
  static const Color shimmerHighlight = Color(0xFFF8FAFC);
  static const Color shimmerBaseDark = Color(0xFF334155);
  static const Color shimmerHighlightDark = Color(0xFF475569);
  
  // Special
  static const Color badge = Color(0xFFEF4444);
  static const Color chip = Color(0xFFF1F5F9);
  static const Color chipDark = Color(0xFF334155);
}
