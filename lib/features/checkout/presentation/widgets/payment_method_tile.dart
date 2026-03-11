import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';

class PaymentMethodTile extends StatelessWidget {
  final String method;
  final bool isSelected;
  final VoidCallback onTap;

   const PaymentMethodTile({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(method);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
            // Payment icon container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: config.bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(config.icon, color: config.iconColor, size: 22),
            ),
             SizedBox(width: 12),
            // Payment name and description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: context.primaryTextColor,
                    ),
                  ),
                  if (config.description != null) ...[
                     SizedBox(height: 2),
                    Text(
                      config.description!,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: context.secondaryTextColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
             SizedBox(width: 8),
            // Selection indicator
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.accent : context.borderColor,
                  width: isSelected ? 6 : 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _PaymentConfig _getConfig(String method) {
    if (method.contains('QRIS')) {
      return _PaymentConfig(
        icon: Icons.qr_code_2,
        iconColor: Colors.black87,
        bgColor:  Color(0xFFF5F5F5),
        description: 'Bayar dengan scan QR',
      );
    } else if (method.contains('GoPay')) {
      return _PaymentConfig(
        icon: Icons.account_balance_wallet,
        iconColor: Colors.white,
        bgColor:  Color(0xFF00AA13),
        description: 'Dompet digital GoPay',
      );
    } else if (method.contains('OVO')) {
      return _PaymentConfig(
        icon: Icons.account_balance_wallet,
        iconColor: Colors.white,
        bgColor:  Color(0xFF4C3494),
        description: 'Dompet digital OVO',
      );
    } else if (method.contains('ShopeePay')) {
      return _PaymentConfig(
        icon: Icons.account_balance_wallet,
        iconColor: Colors.white,
        bgColor:  Color(0xFFEE4D2D),
        description: 'Dompet digital ShopeePay',
      );
    } else if (method.contains('Virtual Account')) {
      return _PaymentConfig(
        icon: Icons.account_balance,
        iconColor: AppColors.accent,
        bgColor: AppColors.accent.withValues(alpha: 0.1),
        description: 'Transfer via Virtual Account',
      );
    } else {
      return _PaymentConfig(
        icon: Icons.payment,
        iconColor: AppColors.accent,
        bgColor: AppColors.accent.withValues(alpha: 0.1),
        description: null,
      );
    }
  }
}

class _PaymentConfig {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String? description;

  const _PaymentConfig({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.description,
  });
}
