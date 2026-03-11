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
          ProductListFetch(
            category: cat == 'Semua' ? null : cat,
          ),
        );
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductListBloc>().add( ProductListLoadMore());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll - 300;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios_new_rounded, size: 20),
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
            icon:  Icon(Icons.search_rounded),
            color: context.primaryTextColor,
            onPressed: () => context.go('/search'),
          ),
          IconButton(
            icon:  Icon(Icons.tune_rounded),
            color: context.primaryTextColor,
            onPressed: () {},
          ),
           SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize:  Size.fromHeight(1),
          child: Container(
            height: 1,
            color: context.dividerColor,
          ),
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
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.productCategories.length,
              separatorBuilder: (_, _) =>  SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = AppConstants.productCategories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedCategory = category);
                    _fetchProducts(category: category);
                  },
                  child: AnimatedContainer(
                    duration:  Duration(milliseconds: 180),
                    padding:  EdgeInsets.symmetric(
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
    return GridView.builder(
      controller: _scrollController,
      padding:  EdgeInsets.all(16),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: state.products.length + (state.hasMore ? 2 : 0),
      itemBuilder: (context, index) {
        if (index >= state.products.length) {
          return _buildShimmerCard();
        }
        return ProductCard(product: state.products[index]);
      },
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding:  EdgeInsets.all(16),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (_, _) => _buildShimmerCard(),
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
           SizedBox(height: 16),
          Text(
            'Tidak ada produk ditemukan',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.primaryTextColor,
            ),
          ),
           SizedBox(height: 6),
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
              'Terjadi Kesalahan',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            ),
             SizedBox(height: 6),
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
              onPressed: _fetchProducts,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding:  EdgeInsets.symmetric(
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
