import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StyloButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final _ButtonVariant _variant;
  final IconData? icon;

   const StyloButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  }) : _variant = _ButtonVariant.primary;

   const StyloButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  }) : _variant = _ButtonVariant.secondary;

   const StyloButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  }) : _variant = _ButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final loadingIndicator = SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          _variant == _ButtonVariant.primary
              ? Colors.white
              : AppColors.accent,
        ),
      ),
    );

    final content = isLoading
        ? loadingIndicator
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18),
                   SizedBox(width: 8),
                  Text(label),
                ],
              )
            : Text(label);

    Widget button;
    switch (_variant) {
      case _ButtonVariant.primary:
        button = SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              elevation: 0,
              disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle:  TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            child: content,
          ),
        );
      case _ButtonVariant.secondary:
        button = SizedBox(
          height: 52,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.accent,
              backgroundColor: Colors.white,
              side:  BorderSide(color: AppColors.accent, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle:  TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            child: content,
          ),
        );
      case _ButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accent,
            textStyle:  TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: content,
        );
    }

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}

enum _ButtonVariant { primary, secondary, text }
