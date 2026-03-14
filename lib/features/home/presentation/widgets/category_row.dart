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

class _CategoryRowState extends State<CategoryRow>
    with TickerProviderStateMixin {
  String? _selectedId;
  late AnimationController _controller;
  final Map<int, Animation<double>> _animations = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<double> _getAnimation(int index) {
    if (!_animations.containsKey(index)) {
      _animations[index] = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.0 + (index * 0.1),
            0.8 + (index * 0.1),
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    }
    return _animations[index]!;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return _buildShimmerPlaceholder();
    }

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final isSelected = _selectedId == category.id;
          final animation = _getAnimation(index);

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.2 + (index * 0.05), 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  0.0 + (index * 0.1),
                  0.8 + (index * 0.1),
                  curve: Curves.easeOutCubic,
                ),
              )),
              child: _CategoryChip(
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
              ),
            ),
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
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
        duration: const Duration(milliseconds: 200),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
