import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/banner.dart' as entity;
import '../../../../core/theme/theme_ext.dart';

class BannerCarousel extends StatefulWidget {
  final List<entity.Banner> banners;

   const BannerCarousel({super.key, required this.banners});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.banners.length > 1) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic( Duration(seconds: 3), (_) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % widget.banners.length;
      _pageController.animateToPage(
        nextPage,
        duration:  Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return _buildShimmerPlaceholder();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final entity.Banner banner = widget.banners[index];
              return _BannerItem(banner: banner);
            },
          ),
        ),
        if (widget.banners.length > 1) ...[
           SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.banners.length,
              (index) => AnimatedContainer(
                duration:  Duration(milliseconds: 250),
                margin:  EdgeInsets.symmetric(horizontal: 3),
                width: _currentPage == index ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.accent
                      : context.dividerColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Shimmer.fromColors(
          baseColor: context.isDarkMode ? AppColors.darkDivider : AppColors.shimmerBase,
          highlightColor: context.isDarkMode ? AppColors.darkSurface : AppColors.shimmerHighlight,
          child: Container(
            height: 200,
            margin:  EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
         SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              margin:  EdgeInsets.symmetric(horizontal: 3),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: context.dividerColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BannerItem extends StatelessWidget {
  final entity.Banner banner;

  const _BannerItem({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.surfaceColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: banner.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: context.isDarkMode ? AppColors.darkDivider : AppColors.shimmerBase,
              highlightColor: context.isDarkMode ? AppColors.darkSurface : AppColors.shimmerHighlight,
              child: Container(color: Colors.white),
            ),
            errorWidget: (context, url, error) => Container(
              color: context.surfaceColor,
              child:  Icon(
                Icons.image_not_supported_outlined,
                color: context.secondaryTextColor,
                size: 48,
              ),
            ),
          ),
          if (banner.title != null || banner.subtitle != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:  EdgeInsets.fromLTRB(16, 32, 16, 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (banner.title != null)
                      Text(
                        banner.title!,
                        style:  TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    if (banner.subtitle != null)
                      Text(
                        banner.subtitle!,
                        style:  TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
