import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/product.dart';
import '../../../../core/theme/theme_ext.dart';
import '../../../wishlist/domain/entities/wishlist_product.dart';
import '../../../wishlist/presentation/bloc/wishlist_bloc.dart';
import '../../../wishlist/presentation/bloc/wishlist_event.dart';
import '../../../wishlist/presentation/bloc/wishlist_state.dart';

class ProductCard extends StatelessWidget {
  final Product product;

   const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(product.discountPrice ?? product.price);

    final formattedOriginalPrice = product.discountPrice != null
        ? NumberFormat.currency(
            locale: 'id_ID',
            symbol: 'Rp ',
            decimalDigits: 0,
          ).format(product.price)
        : null;

    final discountPercent = product.discountPrice != null
        ? (((product.price - product.discountPrice!) / product.price) * 100)
            .toStringAsFixed(0)
        : null;

    return GestureDetector(
      onTap: () => context.push('/products/${product.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset:  Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:  BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: product.images.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: product.images.first,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: context.dividerColor,
                              highlightColor: context.surfaceColor,
                              child: Container(color: context.dividerColor),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: context.surfaceColor,
                              child:  Icon(
                                Icons.image_not_supported_outlined,
                                color: context.secondaryTextColor,
                                size: 32,
                              ),
                            ),
                          )
                        : Container(
                            color: context.surfaceColor,
                            child:  Icon(
                              Icons.image_not_supported_outlined,
                              color: context.secondaryTextColor,
                              size: 32,
                            ),
                          ),
                  ),
                  // AI Try-On badge — top-left
                  if (product.hasAiTryOn)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding:  EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '\u2736 AI Try-On',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  // Discount badge — top-right
                  if (discountPercent != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding:  EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '-$discountPercent%',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  // Wishlist heart — bottom-right
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: BlocBuilder<WishlistBloc, WishlistState>(
                      builder: (context, wishState) {
                        final isLiked = wishState is WishlistLoaded &&
                            wishState.isWishlisted(product.id);
                        return GestureDetector(
                          onTap: () {
                            context.read<WishlistBloc>().add(
                                  WishlistToggle(
                                    WishlistProduct(
                                      id: product.id,
                                      name: product.name,
                                      price: product.price,
                                      discountPrice: product.discountPrice,
                                      imageUrl: product.images.isNotEmpty
                                          ? product.images.first
                                          : '',
                                      category: product.category,
                                      rating: product.rating,
                                    ),
                                  ),
                                );
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(
                              isLiked
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 16,
                              color: isLiked
                                  ? AppColors.accent
                                  : AppColors.lightSecondaryText,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Info section
            Padding(
              padding:  EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: context.primaryTextColor,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                   SizedBox(height: 4),
                  Text(
                    formattedPrice,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accent,
                    ),
                  ),
                  if (formattedOriginalPrice != null) ...[
                     SizedBox(height: 1),
                    Text(
                      formattedOriginalPrice,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: context.secondaryTextColor,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: context.secondaryTextColor,
                      ),
                    ),
                  ],
                   SizedBox(height: 4),
                  Row(
                    children: [
                       Icon(
                        Icons.star_rounded,
                        size: 13,
                        color: AppColors.starFilled,
                      ),
                       SizedBox(width: 2),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: context.secondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                       SizedBox(width: 4),
                      Text(
                        '\u00b7 ${product.reviewCount} terjual',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: context.secondaryTextColor,
                        ),
                      ),
                    ],
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
