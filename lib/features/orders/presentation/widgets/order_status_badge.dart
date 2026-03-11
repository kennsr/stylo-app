import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';

class OrderStatusBadge extends StatelessWidget {
  final String status;

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(context, status);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: config.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: config.color.withValues(alpha: 0.4)),
      ),
      child: Text(
        config.label,
        style: TextStyle(
          color: config.color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  _StatusConfig _getConfig(BuildContext context, String status) {
    final normalized = status.toLowerCase();
    if (normalized.contains('menunggu') || normalized == 'pending') {
      return _StatusConfig(AppColors.warning, 'Menunggu');
    } else if (normalized.contains('diproses') || normalized == 'processing') {
      return _StatusConfig(AppColors.info, 'Diproses');
    } else if (normalized.contains('dikirim') || normalized == 'shipped') {
      return _StatusConfig(Colors.purple, 'Dikirim');
    } else if (normalized.contains('selesai') ||
        normalized == 'completed' ||
        normalized == 'delivered') {
      return _StatusConfig(AppColors.success, 'Selesai');
    } else if (normalized.contains('dibatalkan') || normalized == 'cancelled') {
      return _StatusConfig(AppColors.error, 'Dibatalkan');
    } else {
      return _StatusConfig(context.secondaryTextColor, status);
    }
  }
}

class _StatusConfig {
  final Color color;
  final String label;

  const _StatusConfig(this.color, this.label);
}
