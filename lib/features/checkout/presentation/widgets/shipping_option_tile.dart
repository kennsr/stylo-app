import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/shipping_option.dart';
import '../../../../core/theme/theme_ext.dart';

class ShippingOptionTile extends StatelessWidget {
  final ShippingOption option;
  final bool isSelected;
  final VoidCallback onTap;

   const ShippingOptionTile({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent.withValues(alpha: 0.04)
              : context.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.accent : context.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Accent left border indicator when selected
            AnimatedContainer(
              duration:  Duration(milliseconds: 200),
              width: 4,
              height: 68,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accent : Colors.transparent,
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
             SizedBox(width: 12),
            // Courier info
            Expanded(
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          option.courier,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: context.primaryTextColor,
                          ),
                        ),
                         SizedBox(width: 8),
                        Container(
                          padding:  EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.accent.withValues(alpha: 0.1)
                                : context.surfaceColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            option.service,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? AppColors.accent
                                  : context.secondaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                     SizedBox(height: 3),
                    Text(
                      'Estimasi ${option.estimatedDays} hari',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: context.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Price
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                formatter.format(option.cost),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
