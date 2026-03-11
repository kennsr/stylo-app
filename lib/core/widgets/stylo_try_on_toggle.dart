import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../../core/theme/theme_ext.dart';

class StyloTryOnToggle extends StatelessWidget {
  final bool isOn;
  final ValueChanged<bool> onChanged;

   const StyloTryOnToggle({
    super.key,
    required this.isOn,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
           EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.25),
            blurRadius: 16,
            offset:  Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           Icon(
            Icons.auto_awesome,
            color: AppColors.accent,
            size: 16,
          ),
           SizedBox(width: 6),
          Text(
            'Stylo AI Try-On',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.primaryTextColor,
            ),
          ),
           SizedBox(width: 10),
          SizedBox(
            height: 28,
            child: FittedBox(
              fit: BoxFit.contain,
              child: CupertinoSwitch(
                value: isOn,
                onChanged: onChanged,
                activeTrackColor: AppColors.accent,
                inactiveTrackColor: context.borderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
