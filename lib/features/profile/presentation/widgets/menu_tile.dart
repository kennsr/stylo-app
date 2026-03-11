import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool isDestructive;

   const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? AppColors.error
        : Theme.of(context).colorScheme.onSurface;

    return ListTile(
      leading: Icon(icon, color: isDestructive ? AppColors.error : AppColors.accent),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight:
                  isDestructive ? FontWeight.w600 : FontWeight.w500,
            ),
      ),
      trailing: trailing ??
          (onTap != null && !isDestructive
              ? Icon(
                  Icons.chevron_right,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.4),
                )
              : null),
      onTap: onTap,
      contentPadding:
           EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      dense: true,
    );
  }
}
