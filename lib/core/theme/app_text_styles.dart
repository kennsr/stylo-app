import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme_ext.dart';

class AppTextStyles {
  // Headings - Playfair Display (Serif for brand/editorial)
  // H1 - Product Titles (28px Bold)
  static TextStyle displayLarge(BuildContext context) => GoogleFonts.playfairDisplay(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: context.primaryTextColor,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle displayMedium(BuildContext context) => GoogleFonts.playfairDisplay(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: context.primaryTextColor,
    letterSpacing: -0.3,
    height: 1.25,
  );

  // H2 - Section Headers (22px Semi-Bold)
  static TextStyle headlineLarge(BuildContext context) => GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: context.primaryTextColor,
    height: 1.3,
    letterSpacing: -0.2,
  );

  static TextStyle headlineMedium(BuildContext context) => GoogleFonts.playfairDisplay(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: context.primaryTextColor,
    height: 1.3,
  );

  // H3 - Subsections/Cards (18px Medium - Inter now)
  static TextStyle headlineSmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: context.primaryTextColor,
    height: 1.4,
  );

  static TextStyle titleLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: context.primaryTextColor,
  );

  // Body & UI - Inter (Sans-Serif for interface)
  static TextStyle titleMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: context.primaryTextColor,
  );

  static TextStyle titleSmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: context.primaryTextColor,
  );

  // Body Text (14px Regular)
  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: context.primaryTextColor,
    height: 1.5,
  );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: context.primaryTextColor,
    height: 1.5,
  );

  static TextStyle bodySmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: context.secondaryTextColor,
    height: 1.4,
  );

  // Product Description (13px Regular)
  static TextStyle productDescription(BuildContext context) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: context.secondaryTextColor,
    height: 1.5,
  );

  // Interface/Labels (12px Medium)
  static TextStyle labelLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  static TextStyle labelMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: context.secondaryTextColor,
    letterSpacing: 0.1,
  );

  static TextStyle labelSmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: context.secondaryTextColor,
  );

  // Caption/Helper (11px Regular)
  static TextStyle caption(BuildContext context) => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: context.secondaryTextColor,
    height: 1.4,
  );

  // Price (18px Bold)
  static TextStyle price(BuildContext context) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: context.primaryTextColor,
    letterSpacing: -0.3,
  );

  static TextStyle priceSmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: context.primaryTextColor,
  );

  static TextStyle originalPrice(BuildContext context) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: context.tertiaryTextColor,
    decoration: TextDecoration.lineThrough,
  );

  // Size/Color Labels (13px Medium)
  static TextStyle sizeLabel(BuildContext context) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: context.primaryTextColor,
  );

  // Button Text (14px Semi-Bold)
  static TextStyle buttonText(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.2,
  );

  // Section Header (22px Semi-Bold - Playfair)
  static TextStyle sectionHeader(BuildContext context) => GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: context.primaryTextColor,
    letterSpacing: -0.2,
  );

  // AppBar Title (Playfair for brand consistency)
  static TextStyle appBarTitle(BuildContext context) => GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: context.primaryTextColor,
    letterSpacing: -0.3,
  );
}
