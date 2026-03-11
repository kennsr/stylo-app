import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
   const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'stylo',
      style: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.accent,
        letterSpacing: -0.5,
      ),
    );
  }
}
