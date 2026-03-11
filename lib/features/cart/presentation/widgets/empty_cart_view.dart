import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';

class EmptyCartView extends StatelessWidget {
   const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: context.secondaryTextColor,
            ),
             SizedBox(height: 24),
            Text(
              'Keranjang Kosong',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.primaryTextColor,
              ),
            ),
             SizedBox(height: 8),
            Text(
              'Belum ada produk di keranjang kamu',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: context.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 32),
            OutlinedButton(
              onPressed: () => context.go('/home'),
              style: OutlinedButton.styleFrom(
                side:  BorderSide(color: AppColors.accent, width: 1.5),
                padding:  EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Mulai Belanja',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
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
