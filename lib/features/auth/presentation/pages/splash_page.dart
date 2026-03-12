import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';

/// Splash screen — purely decorative.
/// Auth check is dispatched by [_StyloAppState.initState] in app.dart.
/// GoRouter's redirect handles navigation away from this page once
/// the auth state resolves.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'stylo',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: AppColors.accent,
                      letterSpacing: -1,
                    ),
                  ),
                   SizedBox(height: 10),
                  Container(
                    width: 40,
                    height: 2,
                    color: AppColors.accent,
                  ),
                   SizedBox(height: 12),
                  Text(
                    'Fashion, Reimagined.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: context.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                    valueColor:
                         AlwaysStoppedAnimation<Color>(AppColors.accent),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
