import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/auth/domain/entities/user.dart';
import '../../../../core/theme/theme_ext.dart';

class ProfileHeader extends StatelessWidget {
  final User user;

   const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.accent.withValues(alpha: 0.15),
            child: user.avatarUrl != null
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user.avatarUrl!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => const _DefaultAvatar(),
                      errorWidget: (_, _, _) => const _DefaultAvatar(),
                    ),
                  )
                : const _DefaultAvatar(),
          ),
           SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                 SizedBox(height: 4),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: context.secondaryTextColor,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (user.phone != null) ...[
                   SizedBox(height: 2),
                  Text(
                    user.phone!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: context.secondaryTextColor,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar();

  @override
  Widget build(BuildContext context) {
    return  Icon(
      Icons.person,
      size: 40,
      color: AppColors.accent,
    );
  }
}
