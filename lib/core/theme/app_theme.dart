import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme:  ColorScheme.light(
        primary: AppColors.accent,
        onPrimary: Colors.white,
        secondary: AppColors.accentLight,
        onSecondary: Colors.white,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightPrimaryText,
        error: AppColors.error,
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.lightPrimaryText,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        shadowColor: AppColors.lightDivider,
        centerTitle: true,
        iconTheme:  IconThemeData(color: AppColors.lightPrimaryText),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.lightPrimaryText,
          letterSpacing: 0.1,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightBackground,
        elevation: 0,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize:  Size(0, 52),
          padding:  EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accent,
          backgroundColor: Colors.white,
          side:  BorderSide(color: AppColors.accent, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize:  Size(0, 52),
          padding:  EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding:
             EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.error, width: 1.5),
        ),
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.lightSecondaryText,
        ),
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.lightSecondaryText,
        ),
        errorStyle: GoogleFonts.poppins(
          fontSize: 12,
          color: AppColors.error,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 0,
        height: 64,
        indicatorColor: AppColors.accent.withValues(alpha: 0.1),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return  IconThemeData(color: AppColors.accent, size: 24);
          }
          return  IconThemeData(
              color: AppColors.lightSecondaryText, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.accent,
            );
          }
          return GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.lightSecondaryText,
          );
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedColor: AppColors.accent,
        labelStyle: GoogleFonts.poppins(fontSize: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side:  BorderSide(color: AppColors.lightBorder),
      ),
      dividerTheme:  DividerThemeData(
        color: AppColors.lightDivider,
        thickness: 1,
        space: 0,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme:  ColorScheme.dark(
        primary: AppColors.accentLight,
        onPrimary: Colors.white,
        secondary: AppColors.accent,
        onSecondary: Colors.white,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkPrimaryText,
        error: AppColors.error,
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkPrimaryText,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        shadowColor: AppColors.darkDivider,
        centerTitle: true,
        iconTheme:  IconThemeData(color: AppColors.darkPrimaryText),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.darkPrimaryText,
          letterSpacing: 0.1,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side:  BorderSide(color: AppColors.darkDivider, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize:  Size(0, 52),
          padding:  EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accentLight,
          side:  BorderSide(color: AppColors.accentLight, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize:  Size(0, 52),
          padding:  EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accentLight,
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        contentPadding:
             EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
               BorderSide(color: AppColors.accentLight, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.error, width: 1.5),
        ),
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.darkSecondaryText,
        ),
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.darkSecondaryText,
        ),
        errorStyle: GoogleFonts.poppins(
          fontSize: 12,
          color: AppColors.error,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
        height: 64,
        indicatorColor: AppColors.accentLight.withValues(alpha: 0.15),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return  IconThemeData(color: AppColors.accentLight, size: 24);
          }
          return  IconThemeData(
              color: AppColors.darkSecondaryText, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.accentLight,
            );
          }
          return GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.darkSecondaryText,
          );
        }),
      ),
      dividerTheme:  DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1,
        space: 0,
      ),
    );
  }
}
