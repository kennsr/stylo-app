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
      child: Container(
        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: _buildImageSection(context, discountPercent),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: context.primaryTextColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  if (product.discountPrice != null) ...[
                    Text(
                      _formatCurrency(product.price),
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: context.secondaryTextColor,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: context.secondaryTextColor,
                      ),
                    ),
                    Text(
                      _formatCurrency(product.discountPrice!),
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                    ),
                  ] else
                    Text(
                      _formatCurrency(product.price),
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                    ),
                  if (product.rating != null) ...[
                    SizedBox(height: 4),
                    _buildRating(context, product.rating!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, int discountPercent) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildImage(context),
          if (product.hasAiTryOn)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '\u2736 AI',
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (discountPercent > 0)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '-$discountPercent%',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return product.imageUrl != null
        ? CachedNetworkImage(
            imageUrl: product.imageUrl!,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: context.isDarkMode
                  ? AppColors.darkDivider
                  : AppColors.shimmerBase,
              highlightColor: context.isDarkMode
                  ? AppColors.darkSurface
                  : AppColors.shimmerHighlight,
              child: Container(color: Colors.white),
            ),
            errorWidget: (context, url, error) => Container(
              color: context.surfaceColor,
              child: Icon(
                Icons.image_not_supported_outlined,
                color: context.secondaryTextColor,
                size: 40,
              ),
            ),
          )
        : Container(
            color: context.surfaceColor,
            child: Icon(
              Icons.image_outlined,
              color: context.secondaryTextColor,
              size: 40,
            ),
          );
  }

  Widget _buildRating(BuildContext context, double rating) {
    return Row(
      children: [
        Icon(Icons.star_rounded, size: 13, color: AppColors.starFilled),
        SizedBox(width: 2),
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
