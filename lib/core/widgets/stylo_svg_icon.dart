import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Reusable SVG icon widget for the entire app.
/// 
/// Usage:
/// ```dart
/// StyloSvgIcon('app_icon.svg', size: 48)
/// StyloSvgIcon('icons/home.svg', size: 24, color: AppColors.accent)
/// ```
class StyloSvgIcon extends StatelessWidget {
  /// SVG file path relative to assets/icons/ folder
  /// Example: 'app_icon.svg' or 'subfolder/icon.svg'
  final String name;
  
  /// Icon size (width and height)
  final double? size;
  
  /// Width (overrides size if provided)
  final double? width;
  
  /// Height (overrides size if provided)
  final double? height;
  
  /// Color filter (null = original SVG colors)
  final Color? color;
  
  /// Opacity (0.0 to 1.0)
  final double opacity;
  
  /// Additional SVG theme data
  final SvgTheme? theme;

  const StyloSvgIcon(
    this.name, {
    super.key,
    this.size,
    this.width,
    this.height,
    this.color,
    this.opacity = 1.0,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: SvgPicture.asset(
        'assets/icons/$name',
        width: width ?? size,
        height: height ?? size,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        theme: theme,
        placeholderBuilder: (context) => SizedBox(
          width: width ?? size ?? 24,
          height: height ?? size ?? 24,
          child: Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// App logo widget using SVG
class StyloLogo extends StatelessWidget {
  final double? size;
  final Color? color;

  const StyloLogo({
    super.key,
    this.size = 48,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return StyloSvgIcon(
      'stylo-logo.svg',
      size: size,
      color: color,
    );
  }
}

/// Bottom navigation bar icons using SVG
class StyloNavIcon extends StatelessWidget {
  final String icon;
  final bool isActive;
  final double size;

  const StyloNavIcon({
    super.key,
    required this.icon,
    required this.isActive,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return StyloSvgIcon(
      icon,
      size: size,
      color: isActive
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }
}
