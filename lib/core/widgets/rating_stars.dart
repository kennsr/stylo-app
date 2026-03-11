import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../../core/theme/theme_ext.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final double starSize;

   const RatingStars({
    super.key,
    required this.rating,
    this.reviewCount = 0,
    this.starSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (i) {
          final filled = i < rating.floor();
          final half = !filled && i < rating;
          return Icon(
            filled
                ? Icons.star_rounded
                : (half
                    ? Icons.star_half_rounded
                    : Icons.star_outline_rounded),
            color: filled || half
                ? AppColors.starFilled
                : AppColors.starEmpty,
            size: starSize,
          );
        }),
         SizedBox(width: 4),
        Text(
          '$rating',
          style: GoogleFonts.poppins(
            fontSize: starSize - 3,
            fontWeight: FontWeight.w600,
            color: context.primaryTextColor,
          ),
        ),
        if (reviewCount > 0) ...[
          Text(
            ' • $reviewCount ulasan',
            style: GoogleFonts.poppins(
              fontSize: starSize - 4,
              color: context.secondaryTextColor,
            ),
          ),
        ],
      ],
    );
  }
}
