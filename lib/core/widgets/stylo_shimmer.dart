import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';

class StyloShimmer extends StatelessWidget {
  final Widget child;
   const StyloShimmer({super.key, required this.child});

  static Widget _shimmerBox(
      {double? width, double? height, double radius = 8}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  static Widget card({double? width, double height = 240}) {
    return _StyloShimmerWrapper(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static Widget listTile() {
    return _StyloShimmerWrapper(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            _shimmerBox(width: 56, height: 56, radius: 8),
             SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerBox(width: double.infinity, height: 14),
                   SizedBox(height: 8),
                  _shimmerBox(width: 120, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget productGrid({int count = 6}) {
    return _StyloShimmerWrapper(
      child: GridView.builder(
        shrinkWrap: true,
        physics:  NeverScrollableScrollPhysics(),
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: count,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static Widget productDetail() {
    return _StyloShimmerWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 400,
            color: Colors.white,
          ),
           SizedBox(height: 16),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(width: double.infinity, height: 20),
                 SizedBox(height: 8),
                _shimmerBox(width: 150, height: 14),
                 SizedBox(height: 16),
                _shimmerBox(width: 120, height: 24),
                 SizedBox(height: 16),
                Row(
                  children: [
                    _shimmerBox(width: 44, height: 36),
                     SizedBox(width: 8),
                    _shimmerBox(width: 44, height: 36),
                     SizedBox(width: 8),
                    _shimmerBox(width: 44, height: 36),
                     SizedBox(width: 8),
                    _shimmerBox(width: 44, height: 36),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget paragraph({int lines = 3}) {
    return _StyloShimmerWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(lines, (i) {
          return Padding(
            padding:  EdgeInsets.only(bottom: 8),
            child: _shimmerBox(
              width: i == lines - 1 ? 200 : double.infinity,
              height: 14,
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _StyloShimmerWrapper(child: child);
  }
}

class _StyloShimmerWrapper extends StatelessWidget {
  final Widget child;
  const _StyloShimmerWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark
          ? AppColors.darkSurfaceHigh
          : AppColors.shimmerBase,
      highlightColor: isDark
          ? AppColors.darkBorder
          : AppColors.shimmerHighlight,
      child: child,
    );
  }
}
