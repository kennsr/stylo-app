import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../../core/theme/theme_ext.dart';

class ErrorView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? buttonLabel;
  final VoidCallback? onRetry;

   const ErrorView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.buttonLabel,
    this.onRetry,
  });

  factory ErrorView.network({VoidCallback? onRetry}) => ErrorView(
        icon: Icons.wifi_off_rounded,
        title: 'Koneksi Ilang 📶',
        message: 'Koneksi internet kamu lagi bermasalah nih. Cek dulu ya!',
        buttonLabel: 'Coba Lagi',
        onRetry: onRetry,
      );

  factory ErrorView.server({VoidCallback? onRetry}) => ErrorView(
        icon: Icons.cloud_off_rounded,
        title: 'Server Lagi Error ☁️',
        message: 'Server kami lagi ada masalah. Coba beberapa saat lagi ya!',
        buttonLabel: 'Coba Lagi',
        onRetry: onRetry,
      );

  factory ErrorView.empty({
    required String title,
    required String message,
    String? buttonLabel,
    VoidCallback? onAction,
  }) =>
      ErrorView(
        icon: Icons.inbox_outlined,
        title: title,
        message: message,
        buttonLabel: buttonLabel,
        onRetry: onAction,
      );

  factory ErrorView.custom({
    required IconData icon,
    required String title,
    required String message,
    String? buttonLabel,
    VoidCallback? onRetry,
  }) =>
      ErrorView(
        icon: icon,
        title: title,
        message: message,
        buttonLabel: buttonLabel,
        onRetry: onRetry,
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: context.surfaceColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 36,
                color: context.secondaryTextColor,
              ),
            ),
             SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 8),
            Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: context.secondaryTextColor,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
               SizedBox(height: 28),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:  EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Text(buttonLabel ?? 'Coba Lagi'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
