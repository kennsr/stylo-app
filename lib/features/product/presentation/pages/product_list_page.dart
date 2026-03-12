import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/product_list_bloc.dart';
import '../bloc/product_list_event.dart';
import '../bloc/product_list_state.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/product_card.dart';
import '../../../../core/theme/theme_ext.dart';

class ProductListPage extends StatefulWidget {
  final String? category;

  const ProductListPage({super.key, this.category});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late String _selectedCategory;
  final ScrollController _scrollController = ScrollController();
  bool _hasActiveFilter = false;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.category ?? 'Semua';
    _fetchProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchProducts({String? category}) {
    final cat = category ?? _selectedCategory;
    context.read<ProductListBloc>().add(
      ProductListFetch(category: cat == 'Semua' ? null : cat),
    );
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductListBloc>().add(const ProductListLoadMore());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll - 300;
  }

  void _showFilterSheet(BuildContext context, ProductListState state) {
    final currentSort = state is ProductListLoaded
        ? state.currentSort
        : ProductSortOption.terbaru;
    final currentMin = state is ProductListLoaded
        ? state.currentMinPrice
        : null;
    final currentMax = state is ProductListLoaded
        ? state.currentMaxPrice
        : null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterSheet(
        currentSort: currentSort,
        currentMinPrice: currentMin,
        currentMaxPrice: currentMax,
        onApply: (sort, min, max) {
          context.read<ProductListBloc>().add(
            ProductListApplyFilter(sort: sort, minPrice: min, maxPrice: max),
          );
          setState(() {
            _hasActiveFilter =
                sort != ProductSortOption.terbaru || min != null || max != null;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductListBloc, ProductListState>(
      listener: (context, state) {
        if (state is ProductListLoaded) {
          if (_hasActiveFilter != state.hasActiveFilter) {
            setState(() => _hasActiveFilter = state.hasActiveFilter);
          }
        }
      },
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.backgroundColor,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            color: context.primaryTextColor,
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Produk',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.primaryTextColor,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_rounded),
              color: context.primaryTextColor,
              onPressed: () => context.go('/search'),
            ),
            BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
                final isActive =
                    state is ProductListLoaded && state.hasActiveFilter;
                final activeCount = state is ProductListLoaded
                    ? state.activeFilterCount
                    : 0;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.tune_rounded,
                        color: isActive
                            ? AppColors.accent
                            : context.primaryTextColor,
                      ),
                      onPressed: () => _showFilterSheet(context, state),
                    ),
                    if (isActive && activeCount > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$activeCount',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(width: 4),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: context.dividerColor),
          ),
        ),
        body: Column(
          children: [
            _buildCategoryFilter(),
            Expanded(
              child: BlocBuilder<ProductListBloc, ProductListState>(
                builder: (context, state) {
                  if (state is ProductListLoading) {
                    return _buildLoadingGrid();
                  }
                  if (state is ProductListError) {
                    return _buildError(state.message);
                  }
                  if (state is ProductListLoaded) {
                    if (state.products.isEmpty) {
                      return _buildEmpty();
                    }
                    return _buildGrid(state);
                  }
                  return _buildLoadingGrid();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      color: context.backgroundColor,
      child: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.productCategories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = AppConstants.productCategories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedCategory = category);
                    _fetchProducts(category: category);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.accent : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.accent
                            : context.borderColor,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      category,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected
                            ? Colors.white
                            : context.secondaryTextColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(height: 1, color: context.dividerColor),
        ],
      ),
    );
  }

  Widget _buildGrid(ProductListLoaded state) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          sliver: SliverToBoxAdapter(
            child: Text(
              '${state.totalProducts} produk ditemukan',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: context.secondaryTextColor,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index >= state.products.length) {
                return _buildShimmerCard();
              }
              return ProductCard(product: state.products[index]);
            }, childCount: state.products.length + (state.hasMore ? 2 : 0)),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: context.dividerColor,
      highlightColor: context.surfaceColor,
      child: Container(
        decoration: BoxDecoration(
          color: context.dividerColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada produk ditemukan',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.primaryTextColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Coba kategori atau filter lainnya',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: context.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
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
              child: Icon(
                Icons.error_outline_rounded,
                size: 36,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Terjadi Kesalahan',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: context.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchProducts,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
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
