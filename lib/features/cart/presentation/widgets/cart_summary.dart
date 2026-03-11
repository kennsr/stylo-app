import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/cart.dart';
import '../../../../core/theme/theme_ext.dart';

class CartSummary extends StatelessWidget {
  final Cart cart;

   const CartSummary({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Container(
      decoration:  BoxDecoration(
        color: context.backgroundColor,
        border: Border(
          top: BorderSide(color: context.dividerColor, width: 1),
        ),
      ),
      padding:  EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Subtotal row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: context.secondaryTextColor,
                ),
              ),
              Text(
                formatter.format(cart.subtotal),
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: context.primaryTextColor,
                ),
              ),
            ],
          ),
           SizedBox(height: 6),
          // Shipping row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ongkos Kirim',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: context.secondaryTextColor,
                ),
              ),
              Text(
                'Dihitung saat checkout',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: context.secondaryTextColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
           SizedBox(height: 10),
           Divider(color: context.dividerColor, height: 1),
           SizedBox(height: 10),
          // Total row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total (${cart.totalItems} item)',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: context.primaryTextColor,
                ),
              ),
              Text(
                formatter.format(cart.subtotal),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
           SizedBox(height: 14),
          // Checkout button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => context.go('/checkout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Checkout',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
