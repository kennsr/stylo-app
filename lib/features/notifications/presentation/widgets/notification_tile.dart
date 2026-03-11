import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';
import '../../domain/entities/notification_item.dart';

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  IconData _getIcon(String type) {
    switch (type) {
      case 'promo':
        return Icons.local_offer_rounded;
      case 'order_update':
        return Icons.receipt_long_rounded;
      case 'system':
      default:
        return Icons.info_rounded;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'promo':
        return AppColors.accent;
      case 'order_update':
        return Colors.blue;
      case 'system':
      default:
        return Colors.orange;
    }
  }

  String _timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes menit lalu';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours jam lalu';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days hari lalu';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks minggu lalu';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months bulan lalu';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years tahun lalu';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = notification.isRead
        ? context.backgroundColor
        : context.surfaceColor;
    final iconColor = _getIconColor(notification.type);
    final icon = _getIcon(notification.type);

    return InkWell(
      onTap: onTap,
      child: Container(
        color: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: notification.isRead
                                ? FontWeight.w500
                                : FontWeight.w700,
                            color: context.primaryTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: context.secondaryTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _timeAgo(notification.createdAt),
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: context.secondaryTextColor,
                      fontWeight: FontWeight.w400,
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
