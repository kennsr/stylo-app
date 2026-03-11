import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/placed_order.dart';
import '../../../../core/theme/theme_ext.dart';

class OrderSuccessPage extends StatelessWidget {
  final PlacedOrder order;

   const OrderSuccessPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: 32, vertical: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       SizedBox(height: 32),
                      // Success icon circle
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child:  Icon(
                          Icons.check_circle_outline,
                          size: 60,
                          color: AppColors.success,
                        ),
                      ),
                       SizedBox(height: 28),
                      Text(
                        'Pesanan Berhasil!',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: context.primaryTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                       SizedBox(height: 12),
                      Text(
                        'Terima kasih! Pesananmu sedang kami proses.',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: context.secondaryTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                       SizedBox(height: 28),
                      // Order ID card
                      Container(
                        width: double.infinity,
                        padding:  EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.surfaceColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: context.dividerColor),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'No. Pesanan',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: context.secondaryTextColor,
                              ),
                            ),
                             SizedBox(height: 4),
                            Text(
                              order.orderNumber,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom action buttons
            Padding(
              padding:  EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => context.go('/orders'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Lihat Pesanan',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: TextButton(
                      onPressed: () => context.go('/home'),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Kembali Berbelanja',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: context.secondaryTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
