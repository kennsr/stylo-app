import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/stylo_svg_icon.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../../domain/entities/banner.dart' as entity;
import '../../domain/entities/category.dart';
import '../../domain/entities/product_summary.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/category_row.dart';
import '../widgets/featured_products_grid.dart';
import '../../../../core/theme/theme_ext.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeFetchData());
  }

  Future<void> _onRefresh() async {
    context.read<HomeBloc>().add( HomeFetchData());
    await Future.delayed( Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: _buildAppBar(context),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeError) {
            return _buildErrorView(context, state.message);
          }

          final isLoading = state is HomeLoading || state is HomeInitial;
          final banners = state is HomeLoaded
              ? state.banners
              : <entity.Banner>[];
          final categories = state is HomeLoaded
              ? state.categories
              : <Category>[];
          final products = state is HomeLoaded
              ? state.featuredProducts
              : <ProductSummary>[];

          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: AppColors.primary,
            child: CustomScrollView(
              slivers: [
                // Search bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    child: _buildInlineSearchBar(context),
                  ),
                ),
                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: isLoading
                        ? _buildBannerShimmer()
                        : BannerCarousel(banners: banners),
                  ),
                ),
                // Categories section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Kategori Kekinian'),
                        const SizedBox(height: 12),
                        isLoading
                            ? _buildCategoryShimmer()
                            : CategoryRow(categories: categories),
                      ],
                    ),
                  ),
                ),
                // Recommended products section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          'Rekomendasi Buat Kamu',
                          onSeeAll: () => context.push('/products'),
                        ),
                        const SizedBox(height: 12),
                        isLoading
                            ? const FeaturedProductsGrid(products: [])
                            : FeaturedProductsGrid(products: products),
                      ],
                    ),
                  ),
                ),
                // Bottom padding for navigation
                const SliverToBoxAdapter(
                  child: SizedBox(height: 32),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.surfaceColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      title: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: StyloLogo(size: 36),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: context.primaryTextColor,
          ),
          onPressed: () => context.push('/notifications'),
          tooltip: 'Notifikasi',
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            final itemCount = cartState is CartLoaded
                ? cartState.cart.totalItems
                : 0;
            return Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    color: context.primaryTextColor,
                  ),
                  onPressed: () => context.go('/cart'),
                  tooltip: 'Keranjang',
                ),
                if (itemCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.badge,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        itemCount > 99 ? '99+' : '$itemCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildInlineSearchBar(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.go('/search'),
        child: Container(
          height: 40,
          margin: const EdgeInsets.only(left: 16, right: 8),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: context.dividerColor),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(
                Icons.search_rounded,
                color: context.tertiaryTextColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Mau cari outfit apa hari ini?',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: context.tertiaryTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: context.primaryTextColor,
              letterSpacing: -0.3,
            ),
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                'Lihat Semua →',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  letterSpacing: -0.1,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBannerShimmer() {
    return Shimmer.fromColors(
      baseColor: context.isDarkMode ? AppColors.shimmerBaseDark : AppColors.shimmerBase,
      highlightColor: context.isDarkMode ? AppColors.shimmerHighlightDark : AppColors.shimmerHighlight,
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildCategoryShimmer() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: context.isDarkMode ? AppColors.shimmerBaseDark : AppColors.shimmerBase,
          highlightColor: context.isDarkMode ? AppColors.shimmerHighlightDark : AppColors.shimmerHighlight,
          child: Container(
            width: 80,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 64,
              color: context.tertiaryTextColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Yah, Ada Masalah 🥲',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: context.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  context.read<HomeBloc>().add( HomeFetchData()),
              icon: const Icon(Icons.refresh_rounded),
              label: Text(
                'Coba Lagi Dong',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
