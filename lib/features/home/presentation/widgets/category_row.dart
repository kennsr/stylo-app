import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/category.dart';
import '../../../../core/theme/theme_ext.dart';

class CategoryRow extends StatefulWidget {
  final List<Category> categories;

   const CategoryRow({super.key, required this.categories});

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return _buildShimmerPlaceholder();
    }

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding:  EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.categories.length,
        separatorBuilder: (context, index) =>  SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final isSelected = _selectedId == category.id;
          return _CategoryChip(
            category: category,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                _selectedId = isSelected ? null : category.id;
              });
              context.go(
                '/products?category=${Uri.encodeComponent(category.name)}',
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding:  EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        separatorBuilder: (context, index) =>  SizedBox(width: 8),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: context.isDarkMode ? AppColors.darkDivider : AppColors.shimmerBase,
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
}

class _CategoryChip extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:  Duration(milliseconds: 200),
        height: 36,
        padding:  EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : context.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.accent : context.borderColor,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          category.name,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? Colors.white
                : context.primaryTextColor,
          ),
        ),
      ),
    );
  }
}
