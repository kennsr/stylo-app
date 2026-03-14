import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/product_summary.dart';
import 'product_summary_card.dart';
import '../../../../core/theme/theme_ext.dart';

class FeaturedProductsGrid extends StatefulWidget {
  final List<ProductSummary> products;

  const FeaturedProductsGrid({super.key, required this.products});

  @override
  State<FeaturedProductsGrid> createState() => _FeaturedProductsGridState();
}

class _FeaturedProductsGridState extends State<FeaturedProductsGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Map<int, Animation<double>> _animations = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(FeaturedProductsGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.products.length > oldWidget.products.length) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<double> _getAnimation(int index) {
    if (!_animations.containsKey(index)) {
      _animations[index] = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.0 + (index * 0.08),
            0.7 + (index * 0.08),
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    }
    return _animations[index]!;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) {
      return _buildShimmerPlaceholder();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.55,
      ),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final product = widget.products[index];
        final animation = _getAnimation(index);

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.15),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _controller,
              curve: Interval(
                0.0 + (index * 0.08),
                0.7 + (index * 0.08),
                curve: Curves.easeOutCubic,
              ),
            )),
            child: ProductSummaryCard(product: product),
          ),
        );
      },
    );
  }

  Widget _buildShimmerPlaceholder() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
