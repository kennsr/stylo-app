import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/product_summary.dart';
import 'product_summary_card.dart';
import '../../../../core/theme/theme_ext.dart';

class FeaturedProductsGrid extends StatelessWidget {
  final List<ProductSummary> products;

   const FeaturedProductsGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return _buildShimmerPlaceholder();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics:  NeverScrollableScrollPhysics(),
      padding:  EdgeInsets.symmetric(horizontal: 16),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.55,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductSummaryCard(product: products[index]);
      },
    );
  }

  Widget _buildShimmerPlaceholder() {
    return GridView.builder(
      shrinkWrap: true,
      physics:  NeverScrollableScrollPhysics(),
      padding:  EdgeInsets.symmetric(horizontal: 16),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.55,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: context.isDarkMode ? AppColors.darkDivider : AppColors.shimmerBase,
        highlightColor: context.isDarkMode ? AppColors.darkSurface : AppColors.shimmerHighlight,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
