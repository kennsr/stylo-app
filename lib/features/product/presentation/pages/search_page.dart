import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/product_list_bloc.dart';
import '../bloc/product_list_event.dart';
import '../bloc/product_list_state.dart';
import '../widgets/product_card.dart';
import '../../../../core/theme/theme_ext.dart';

class SearchPage extends StatefulWidget {
   const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer( Duration(milliseconds: 500), () {
      final trimmed = query.trim();
      if (trimmed == _lastQuery) return;
      _lastQuery = trimmed;
      if (trimmed.isNotEmpty) {
        context.read<ProductListBloc>().add(ProductListFetch(search: trimmed));
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _lastQuery = '');
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        titleSpacing: 16,
        automaticallyImplyLeading: false,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            onChanged: _onSearchChanged,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _focusNode.unfocus(),
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: context.primaryTextColor,
            ),
            decoration: InputDecoration(
              hintText: 'Cari produk favoritmu...',
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: context.secondaryTextColor,
              ),
              border: InputBorder.none,
              contentPadding:  EdgeInsets.symmetric(vertical: 10),
              prefixIcon:  Icon(
                Icons.search_rounded,
                color: context.secondaryTextColor,
                size: 20,
              ),
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _searchController,
                builder: (context, value, child) {
                  return value.text.isNotEmpty
                      ? IconButton(
                          icon:  Icon(Icons.clear_rounded, size: 18),
                          color: context.secondaryTextColor,
                          onPressed: _clearSearch,
                        )
                      :  SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
        actions: const [SizedBox(width: 16)],
        bottom: PreferredSize(
          preferredSize:  Size.fromHeight(1),
          child: Container(height: 1, color: context.dividerColor),
        ),
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (_searchController.text.trim().isEmpty) {
            return _buildEmptyInitial();
          }

          if (state is ProductListLoading) {
            return _buildLoadingGrid();
          }

          if (state is ProductListError) {
            return _buildError(state.message);
          }

          if (state is ProductListLoaded) {
            if (state.products.isEmpty) {
              return _buildNoResults();
            }
            return _buildResults(state);
          }

          return _buildEmptyInitial();
        },
      ),
    );
  }

  Widget _buildEmptyInitial() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: context.surfaceColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_rounded,
              size: 48,
              color: Colors.grey.shade300,
            ),
          ),
           SizedBox(height: 20),
          Text(
            'Ketik untuk mencari...',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.primaryTextColor,
            ),
          ),
           SizedBox(height: 6),
          Text(
            'Temukan pakaian impianmu di sini',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: context.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: context.surfaceColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 48,
              color: Colors.grey.shade300,
            ),
          ),
           SizedBox(height: 20),
          Text(
            'Produk tidak ditemukan',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.primaryTextColor,
            ),
          ),
           SizedBox(height: 6),
          Text(
            'Coba kata kunci yang berbeda',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: context.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(ProductListLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Text(
            '${state.products.length} hasil ditemukan',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: context.secondaryTextColor,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding:  EdgeInsets.all(16),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: state.products[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding:  EdgeInsets.all(16),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (_, _) => Shimmer.fromColors(
        baseColor: context.dividerColor,
        highlightColor: context.surfaceColor,
        child: Container(
          decoration: BoxDecoration(
            color: context.dividerColor,
            borderRadius: BorderRadius.circular(10),
          ),
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
             Icon(
              Icons.error_outline_rounded,
              size: 52,
              color: AppColors.error,
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
          ],
        ),
      ),
    );
  }
}
