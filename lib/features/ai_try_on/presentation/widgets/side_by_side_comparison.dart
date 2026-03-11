import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/theme_ext.dart';

class SideBySideComparison extends StatelessWidget {
  final String modelImageUrl;
  final String userImageUrl;

   const SideBySideComparison({
    super.key,
    required this.modelImageUrl,
    required this.userImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: modelImageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: context.dividerColor,
                    highlightColor: context.surfaceColor,
                    child: Container(
                      height: 300,
                      color: context.dividerColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 300,
                    color: context.surfaceColor,
                    child:  Icon(
                      Icons.image_not_supported_outlined,
                      color: context.secondaryTextColor,
                      size: 40,
                    ),
                  ),
                ),
              ),
               SizedBox(height: 8),
              Text(
                'Model',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: context.secondaryTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
         SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: userImageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: context.dividerColor,
                    highlightColor: context.surfaceColor,
                    child: Container(
                      height: 300,
                      color: context.dividerColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 300,
                    color: context.surfaceColor,
                    child:  Icon(
                      Icons.image_not_supported_outlined,
                      color: context.secondaryTextColor,
                      size: 40,
                    ),
                  ),
                ),
              ),
               SizedBox(height: 8),
              Text(
                'Kamu',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: context.secondaryTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
