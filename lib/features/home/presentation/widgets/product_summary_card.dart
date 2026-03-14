import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/product_summary.dart';
import '../../../../core/theme/theme_ext.dart';

class ProductSummaryCard extends StatelessWidget {
  final ProductSummary product;

  const ProductSummaryCard({super.key, required this.product});

  String _formatCurrency(double price) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(price);
  }

  int _discountPercent() {
    if (product.discountPrice == null || product.price == 0) return 0;
    return (((product.price - product.discountPrice!) / product.price) * 100)
        .round();
  }

  @override
  Widget build(BuildContext context) {
    final discountPercent = _discountPercent();

    return GestureDetector(
      onTap: () => context.push('/products/${product.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed height image section
          SizedBox(
            height: 200,
            width: double.infinity,
            child: _buildImageSection(context, discountPercent),
          ),
          // Product info (no padding container, just direct text)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.primaryTextColor,
                    letterSpacing: -0.2,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                if (product.discountPrice != null) ...[
                  Text(
                    _formatCurrency(product.price),
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: context.tertiaryTextColor,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: context.tertiaryTextColor,
                    ),
                  ),
                  Text(
                    _formatCurrency(product.discountPrice!),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      letterSpacing: -0.3,
                    ),
                  ),
                ] else
                  Text(
                    _formatCurrency(product.price),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      letterSpacing: -0.3,
                    ),
                  ),
                if (product.rating != null) ...[
                  const SizedBox(height: 4),
                  _buildRating(context, product.rating!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, int discountPercent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildImage(context),
        if (product.hasAiTryOn)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.auto_awesome_rounded,
                    size: 10,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    'AI',
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (discountPercent > 0)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '-$discountPercent%',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return product.imageUrl != null
        ? CachedNetworkImage(
            imageUrl: product.imageUrl!,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: context.isDarkMode
                  ? AppColors.shimmerBaseDark
                  : AppColors.shimmerBase,
              highlightColor: context.isDarkMode
                  ? AppColors.shimmerHighlightDark
                  : AppColors.shimmerHighlight,
              child: Container(color: Colors.white),
            ),
            errorWidget: (context, url, error) {
              // Show placeholder with product name when image fails
              return Container(
                color: context.surfaceHighColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported_outlined,
                      color: context.tertiaryTextColor,
                      size: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.name,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: context.primaryTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          )
        : Container(
            color: context.surfaceHighColor,
            child: Icon(
              Icons.image_outlined,
              color: context.tertiaryTextColor,
              size: 40,
            ),
          );
  }

  Widget _buildRating(BuildContext context, double rating) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, size: 14, color: AppColors.starFilled),
        const SizedBox(width: 3),
        Text(
          rating.toStringAsFixed(1),
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: context.secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
