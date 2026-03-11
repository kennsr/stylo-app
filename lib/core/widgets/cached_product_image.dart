import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'stylo_shimmer.dart';

class CachedProductImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxFit fit;

   const CachedProductImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _placeholder();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => StyloShimmer(
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color:  Color(0xFFF0F0F0),
      child:  Icon(Icons.image_not_supported_outlined,
          color: Color(0xFFCCCCCC), size: 32),
    );
  }
}
