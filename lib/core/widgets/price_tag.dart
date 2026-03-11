import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../utils/input_converter.dart';
import '../../core/theme/theme_ext.dart';

class PriceTag extends StatelessWidget {
  final int price;
  final int? originalPrice;
  final double fontSize;
  final bool compact;

   const PriceTag({
    super.key,
    required this.price,
    this.originalPrice,
    this.fontSize = 16,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount =
        originalPrice != null && originalPrice! > price;
    final discountPct = hasDiscount
        ? ((originalPrice! - price) / originalPrice! * 100).round()
        : 0;

    if (compact) {
      return Text(
        InputConverter.formatIDR(price),
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: AppColors.accent,
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          InputConverter.formatIDR(price),
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: context.primaryTextColor,
          ),
        ),
        if (hasDiscount) ...[
           SizedBox(width: 8),
          Text(
            InputConverter.formatIDR(originalPrice!),
            style: GoogleFonts.poppins(
              fontSize: fontSize - 4,
              fontWeight: FontWeight.w400,
              color: context.secondaryTextColor,
              decoration: TextDecoration.lineThrough,
              decorationColor: context.secondaryTextColor,
            ),
          ),
           SizedBox(width: 6),
          Container(
            padding:
                 EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '-$discountPct%',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
