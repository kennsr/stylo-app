import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';
import '../../domain/entities/payment_method.dart';

class PaymentMethodTile extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.paymentMethod,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(paymentMethod.id, paymentMethod.name);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
            const SizedBox(width: 12),
            // Payment name and description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paymentMethod.name,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: context.primaryTextColor,
                    ),
                  ),
                  if (config.description != null) ...[
                    const SizedBox(height: 2),
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
            const SizedBox(width: 8),
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

  // Matches by `id` (from new API contract: cc, gopay, ovo, qris, bca_va, cod)
  // Falls back to name-contains matching for forward compatibility.
  _PaymentConfig _getConfig(String id, String name) {
    switch (id) {
      case 'qris':
        return _PaymentConfig(
          icon: Icons.qr_code_2,
          iconColor: Colors.black87,
          bgColor: const Color(0xFFF5F5F5),
          description: 'Bayar dengan scan QR',
        );
      case 'gopay':
        return _PaymentConfig(
          icon: Icons.account_balance_wallet,
          iconColor: Colors.white,
          bgColor: const Color(0xFF00AA13),
          description: 'Dompet digital GoPay',
        );
      case 'ovo':
        return _PaymentConfig(
          icon: Icons.account_balance_wallet,
          iconColor: Colors.white,
          bgColor: const Color(0xFF4C3494),
          description: 'Dompet digital OVO',
        );
      case 'bca_va':
        return _PaymentConfig(
          icon: Icons.account_balance,
          iconColor: const Color(0xFF003D82),
          bgColor: const Color(0xFFE8F0FB),
          description: 'Transfer via Virtual Account',
        );
      case 'cc':
        return _PaymentConfig(
          icon: Icons.credit_card,
          iconColor: AppColors.accent,
          bgColor: AppColors.accent.withValues(alpha: 0.08),
          description: 'Visa / Mastercard',
        );
      case 'cod':
        return _PaymentConfig(
          icon: Icons.local_shipping_outlined,
          iconColor: const Color(0xFF2E7D32),
          bgColor: const Color(0xFFE8F5E9),
          description: 'Bayar saat barang tiba',
        );
      default:
        // Name-based fallback for any future additions
        if (name.toLowerCase().contains('shopeepay')) {
          return _PaymentConfig(
            icon: Icons.account_balance_wallet,
            iconColor: Colors.white,
            bgColor: const Color(0xFFEE4D2D),
            description: 'Dompet digital ShopeePay',
          );
        }
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
