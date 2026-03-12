import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_event.dart';
import '../bloc/product_detail_state.dart';
import '../widgets/add_to_cart_bar.dart';
import '../widgets/color_selector.dart';
import '../widgets/review_tile.dart';
import '../widgets/size_selector.dart';
import '../../../../core/theme/theme_ext.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

   const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  String? _selectedSize;
  String? _selectedColor;
  bool _descriptionExpanded = false;

  @override
  void initState() {
    super.initState();
    context
        .read<ProductDetailBloc>()
        .add(ProductDetailFetch(productId: widget.productId));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Runs [action] if the user is logged in; otherwise navigates to /login.
  void _requireAuth(VoidCallback action) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      action();
    } else {
      context.push('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      bottomNavigationBar: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoaded) {
            return AddToCartBar(
              onAddToCart: () => _requireAuth(() {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Ditambahkan ke keranjang',
                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: context.primaryTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }),
            );
          }
          return  SizedBox.shrink();
        },
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return _buildLoadingState();
          }
          if (state is ProductDetailError) {
            return _buildError(state.message);
          }
          if (state is ProductDetailLoaded) {
            return _buildContent(state);
          }
          return _buildLoadingState();
        },
      ),
    );
  }

  Widget _buildContent(ProductDetailLoaded state) {
    final product = state.product;
    final reviews = state.reviews;

    final sizes = product.variants.map((v) => v.size).toSet().toList();
    final colors = product.variants.map((v) => v.color).toSet().toList();

    final displayPrice = product.discountPrice ?? product.price;
    final formattedPrice = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(displayPrice);

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

    return CustomScrollView(
      slivers: [
        // Custom SliverAppBar over image
        SliverAppBar(
          expandedHeight: 400,
          pinned: true,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin:  EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon:  Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: context.primaryTextColor,
              ),
              onPressed: () => context.pop(),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: _buildImageCarousel(product),
          ),
        ),
        // Content
        SliverToBoxAdapter(
          child: Container(
            color: context.backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category label
                      Text(
                        product.category.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: context.secondaryTextColor,
                          letterSpacing: 1.2,
                        ),
                      ),
                       SizedBox(height: 6),
                      // Product name
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product.name.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: context.primaryTextColor,
                                height: 1.2,
                              ),
                            ),
                          ),
                          if (product.hasAiTryOn)
                            Container(
                              margin:  EdgeInsets.only(left: 8, top: 2),
                              padding:  EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.accent.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                'AI Try-On',
                                style: GoogleFonts.poppins(
                                  color: AppColors.accent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                       SizedBox(height: 14),
                      // Price row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formattedPrice,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.accent,
                            ),
                          ),
                          if (discountPercent != null) ...[
                             SizedBox(width: 8),
                            Container(
                              padding:  EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '-$discountPercent%',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (formattedOriginalPrice != null)
                        Padding(
                          padding:  EdgeInsets.only(top: 2),
                          child: Text(
                            formattedOriginalPrice,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: context.secondaryTextColor,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: context.secondaryTextColor,
                            ),
                          ),
                        ),
                       SizedBox(height: 12),
                      // Rating + stock row
                      Row(
                        children: [
                           Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: AppColors.starFilled,
                          ),
                           SizedBox(width: 3),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: context.primaryTextColor,
                            ),
                          ),
                           SizedBox(width: 4),
                          Text(
                            '(${product.reviewCount} ulasan)',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: context.secondaryTextColor,
                            ),
                          ),
                           SizedBox(width: 16),
                          Container(
                            width: 1,
                            height: 14,
                            color: context.dividerColor,
                          ),
                           SizedBox(width: 16),
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 14,
                            color: context.secondaryTextColor,
                          ),
                           SizedBox(width: 4),
                          Text(
                            'Stok: ${product.stock}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: context.secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                 SizedBox(height: 16),
                Container(height: 8, color: context.surfaceColor),
                // Size & color selectors
                if (sizes.isNotEmpty || colors.isNotEmpty)
                  Padding(
                    padding:  EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (sizes.isNotEmpty) ...[
                          SizeSelector(
                            sizes: sizes,
                            initialSize: _selectedSize,
                            onSizeSelected: (size) {
                              setState(() => _selectedSize = size);
                            },
                          ),
                           SizedBox(height: 20),
                        ],
                        if (colors.isNotEmpty) ...[
                          ColorSelector(
                            colors: colors,
                            initialColor: _selectedColor,
                            onColorSelected: (color) {
                              setState(() => _selectedColor = color);
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                // AI Try-On button
                if (product.hasAiTryOn) ...[
                   SizedBox(height: 20),
                  Container(height: 8, color: context.surfaceColor),
                  Padding(
                    padding:  EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:  Icon(
                                Icons.auto_awesome_rounded,
                                color: AppColors.accent,
                                size: 22,
                              ),
                            ),
                             SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Stylo AI Try-On',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: context.primaryTextColor,
                                    ),
                                  ),
                                  Text(
                                    'Coba pakaian ini secara virtual',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: context.secondaryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                         SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: () => _requireAuth(() {
                              context.go(
                                '/try-on?productId=${product.id}',
                              );
                            }),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shadowColor: AppColors.accent.withValues(alpha: 0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon:  Icon(
                              Icons.view_in_ar_rounded,
                              size: 22,
                            ),
                            label: Text(
                              'Mulai AI Try-On',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                 SizedBox(height: 20),
                Container(height: 8, color: context.surfaceColor),
                // Description
                Padding(
                  padding:  EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: _buildDescriptionSection(product),
                ),
                 SizedBox(height: 20),
                Container(height: 8, color: context.surfaceColor),
                // Reviews
                Padding(
                  padding:  EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: _buildReviewsSection(reviews),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageCarousel(Product product) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentImageIndex = index);
          },
          itemCount: product.images.isNotEmpty ? product.images.length : 1,
          itemBuilder: (context, index) {
            if (product.images.isEmpty) {
              return Container(
                color: context.surfaceColor,
                child:  Icon(
                  Icons.image_not_supported_outlined,
                  size: 64,
                  color: context.secondaryTextColor,
                ),
              );
            }
            return CachedNetworkImage(
              imageUrl: product.images[index],
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: context.dividerColor,
                highlightColor: context.surfaceColor,
                child: Container(color: context.dividerColor),
              ),
              errorWidget: (context, url, error) => Container(
                color: context.surfaceColor,
                child:  Icon(
                  Icons.image_not_supported_outlined,
                  size: 64,
                  color: context.secondaryTextColor,
                ),
              ),
            );
          },
        ),
        if (product.images.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                product.images.length,
                (index) => AnimatedContainer(
                  duration:  Duration(milliseconds: 200),
                  width: _currentImageIndex == index ? 20 : 7,
                  height: 7,
                  margin:  EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: _currentImageIndex == index
                        ? AppColors.accent
                        : Colors.white.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDescriptionSection(Product product) {
    const maxLines = 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deskripsi Produk',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: context.primaryTextColor,
          ),
        ),
         SizedBox(height: 10),
        AnimatedCrossFade(
          firstChild: Text(
            product.description,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: context.secondaryTextColor,
              height: 1.65,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
          secondChild: Text(
            product.description,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: context.secondaryTextColor,
              height: 1.65,
            ),
          ),
          crossFadeState: _descriptionExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration:  Duration(milliseconds: 200),
        ),
        GestureDetector(
          onTap: () {
            setState(() => _descriptionExpanded = !_descriptionExpanded);
          },
          child: Padding(
            padding:  EdgeInsets.only(top: 8),
            child: Text(
              _descriptionExpanded ? 'Tampilkan lebih sedikit' : 'Selengkapnya',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection(List reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ulasan',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            ),
            Text(
              '${reviews.length} ulasan',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: context.secondaryTextColor,
              ),
            ),
          ],
        ),
         SizedBox(height: 4),
        if (reviews.isEmpty)
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'Belum ada ulasan',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: context.secondaryTextColor,
                ),
              ),
            ),
          )
        else
          ListView.builder(
            physics:  NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return ReviewTile(review: reviews[index]);
            },
          ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        baseColor: context.dividerColor,
        highlightColor: context.surfaceColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 400, color: context.dividerColor),
            Padding(
              padding:  EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: 80,
                    decoration: BoxDecoration(
                      color: context.dividerColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                   SizedBox(height: 10),
                  Container(
                    height: 22,
                    width: 220,
                    decoration: BoxDecoration(
                      color: context.dividerColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                   SizedBox(height: 12),
                  Container(
                    height: 26,
                    width: 140,
                    decoration: BoxDecoration(
                      color: context.dividerColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                   SizedBox(height: 12),
                  Container(
                    height: 16,
                    width: 180,
                    decoration: BoxDecoration(
                      color: context.dividerColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child:  Icon(
                Icons.error_outline_rounded,
                size: 36,
                color: AppColors.error,
              ),
            ),
             SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: context.secondaryTextColor,
              ),
            ),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<ProductDetailBloc>().add(
                      ProductDetailFetch(productId: widget.productId),
                    );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:  EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
              ),
              child: Text(
                'Coba Lagi',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
