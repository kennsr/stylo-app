import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/try_on_result.dart';
import '../../../../core/theme/theme_ext.dart';

class TryOnResultView extends StatefulWidget {
  final TryOnResult result;

   const TryOnResultView({super.key, required this.result});

  @override
  State<TryOnResultView> createState() => _TryOnResultViewState();
}

class _TryOnResultViewState extends State<TryOnResultView> {
  bool _showComparison = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hasil Try-On',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  'Perbandingan',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.secondaryTextColor,
                  ),
                ),
                 SizedBox(width: 6),
                Switch(
                  value: _showComparison,
                  onChanged: (val) {
                    setState(() => _showComparison = val);
                  },
                  activeThumbColor: AppColors.accent,
                ),
              ],
            ),
          ],
        ),
         SizedBox(height: 12),
        AnimatedCrossFade(
          firstChild: _buildSingleResult(),
          secondChild: _buildComparisonResult(),
          crossFadeState: _showComparison
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration:  Duration(milliseconds: 250),
        ),
      ],
    );
  }

  Widget _buildSingleResult() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: widget.result.resultImageUrl,
        width: double.infinity,
        height: 400,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: context.dividerColor,
          highlightColor: context.surfaceColor,
          child: Container(
            height: 400,
            color: context.dividerColor,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: 400,
          color: context.surfaceColor,
          child:  Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 64,
              color: context.secondaryTextColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonResult() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: widget.result.originalImageUrl,
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
                style: TextStyle(
                  color: context.secondaryTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
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
                  imageUrl: widget.result.resultImageUrl,
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
                style: TextStyle(
                  color: context.secondaryTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
