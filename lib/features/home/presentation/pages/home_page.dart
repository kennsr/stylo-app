import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add( HomeFetchData());
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
            color: AppColors.accent,
            child: SingleChildScrollView(
              physics:  AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(context),
                   SizedBox(height: 16),
                  isLoading
                      ? _buildBannerShimmer()
                      : BannerCarousel(banners: banners),
                   SizedBox(height: 24),
                  _buildSectionHeader('Kategori'),
                   SizedBox(height: 12),
                  isLoading
                      ? _buildCategoryShimmer()
                      : CategoryRow(categories: categories),
                   SizedBox(height: 24),
                  _buildSectionHeader(
                    'Rekomendasi',
                    onSeeAll: () => context.go('/products'),
                  ),
                   SizedBox(height: 12),
                  isLoading
                      ?  FeaturedProductsGrid(products: [])
                      : FeaturedProductsGrid(products: products),
                   SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      shadowColor: context.dividerColor,
      centerTitle: false,
      title: Text(
        'stylo',
        style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: AppColors.accent,
          letterSpacing: -0.5,
        ),
      ),
      actions: [
        IconButton(
          icon:  Icon(
            Icons.notifications_outlined,
            color: context.primaryTextColor,
          ),
          onPressed: () {},
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
                  icon:  Icon(
                    Icons.shopping_bag_outlined,
                    color: context.primaryTextColor,
                  ),
                  onPressed: () => context.go('/cart'),
                  tooltip: 'Keranjang',
                ),
                if (itemCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding:  EdgeInsets.all(2),
                      constraints:  BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      decoration:  BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        itemCount > 99 ? '99+' : '$itemCount',
                        style:  TextStyle(
                          color: Colors.white,
                          fontSize: 9,
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
         SizedBox(width: 4),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/search'),
      child: Container(
        margin:  EdgeInsets.fromLTRB(16, 12, 16, 0),
        height: 46,
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: context.dividerColor),
        ),
        child: Row(
          children: [
             SizedBox(width: 14),
             Icon(
              Icons.search_rounded,
              color: context.secondaryTextColor,
              size: 20,
            ),
             SizedBox(width: 8),
            Text(
              'Cari produk fashion...',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: context.secondaryTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: context.primaryTextColor,
            ),
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                'Lihat Semua',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.accent,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBannerShimmer() {
    return Shimmer.fromColors(
      baseColor: context.dividerColor,
      highlightColor: context.isDarkMode ? AppColors.darkSurface : AppColors.shimmerHighlight,
      child: Container(
        height: 200,
        margin:  EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildCategoryShimmer() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding:  EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        separatorBuilder: (context, index) =>  SizedBox(width: 8),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: context.dividerColor,
          highlightColor: context.isDarkMode ? AppColors.darkSurface : AppColors.shimmerHighlight,
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
        padding:  EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
              Icons.wifi_off_rounded,
              size: 64,
              color: context.secondaryTextColor,
            ),
             SizedBox(height: 16),
            Text(
              'Terjadi Kesalahan',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.primaryTextColor,
              ),
            ),
             SizedBox(height: 8),
            Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: context.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  context.read<HomeBloc>().add( HomeFetchData()),
              icon:  Icon(Icons.refresh_rounded),
              label: Text(
                'Coba Lagi',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
