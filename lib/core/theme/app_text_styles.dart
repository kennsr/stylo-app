import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme_ext.dart';

class AppTextStyles {
  // Display
  static TextStyle displayLarge(BuildContext context) => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: context.primaryTextColor,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle displayMedium(BuildContext context) => GoogleFonts.poppins(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: context.primaryTextColor,
    letterSpacing: -0.3,
    height: 1.25,
  );

  // Headline
  static TextStyle headlineLarge(BuildContext context) => GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: context.primaryTextColor,
    height: 1.3,
  );

  static TextStyle headlineMedium(BuildContext context) => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: context.primaryTextColor,
    height: 1.3,
  );

  static TextStyle headlineSmall(BuildContext context) => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: context.primaryTextColor,
    height: 1.4,
  );

  // Title
  static TextStyle titleLarge(BuildContext context) => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: context.primaryTextColor,
  );

  static TextStyle titleMedium(BuildContext context) => GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: context.primaryTextColor,
  );

  static TextStyle titleSmall(BuildContext context) => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: context.primaryTextColor,
  );

  // Body
  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: context.primaryTextColor,
    height: 1.5,
  );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: context.primaryTextColor,
    height: 1.5,
  );

  static TextStyle bodySmall(BuildContext context) => GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: context.secondaryTextColor,
    height: 1.4,
  );

  // Label
  static TextStyle labelLarge(BuildContext context) => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle labelMedium(BuildContext context) => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: context.secondaryTextColor,
    letterSpacing: 0.3,
  );

  static TextStyle labelSmall(BuildContext context) => GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: context.secondaryTextColor,
  );

  // Caption
  static TextStyle caption(BuildContext context) => GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: context.secondaryTextColor,
    height: 1.4,
  );

  // Special
  static TextStyle appBarTitle(BuildContext context) => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: context.primaryTextColor,
    letterSpacing: 0.1,
  );

  static TextStyle price(BuildContext context) => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: context.primaryTextColor,
  );

  static TextStyle priceSmall(BuildContext context) => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: context.primaryTextColor,
  );

  static TextStyle originalPrice(BuildContext context) => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: context.secondaryTextColor,
    decoration: TextDecoration.lineThrough,
  );

  static TextStyle buttonText(BuildContext context) => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static TextStyle sectionHeader(BuildContext context) => GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: context.primaryTextColor,
  );
}
