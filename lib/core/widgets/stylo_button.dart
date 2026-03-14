import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class StyloButton extends StatefulWidget {
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
  State<StyloButton> createState() => _StyloButtonState();
}

class _StyloButtonState extends State<StyloButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _controller.reverse();
      widget.onPressed?.call();
    }
  }

  void _onTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loadingIndicator = SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          widget._variant == _ButtonVariant.primary
              ? Colors.white
              : AppColors.primary,
        ),
      ),
    );

    final content = widget.isLoading
        ? loadingIndicator
        : widget.icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    widget.label,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              )
            : Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              );

    Widget button;
    switch (widget._variant) {
      case _ButtonVariant.primary:
        button = GestureDetector(
          onTapDown: widget.onPressed != null && !widget.isLoading ? _onTapDown : null,
          onTapUp: widget.onPressed != null && !widget.isLoading ? _onTapUp : null,
          onTapCancel: widget.onPressed != null && !widget.isLoading ? _onTapCancel : null,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : widget.onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: widget.onPressed != null && !widget.isLoading ? 2 : 0,
                  shadowColor: widget.onPressed != null && !widget.isLoading
                      ? AppColors.primary.withValues(alpha: 0.4)
                      : Colors.transparent,
                  disabledBackgroundColor:
                      AppColors.primary.withValues(alpha: 0.5),
                  disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: (_isPressed && widget.onPressed != null && !widget.isLoading)
                        ? null
                        : LinearGradient(
                            colors: [
                              AppColors.primaryGradientStart,
                              AppColors.primaryGradientEnd,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: content),
                ),
              ),
            ),
          ),
        );
      case _ButtonVariant.secondary:
        button = GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: SizedBox(
              height: 48,
              child: OutlinedButton(
                onPressed: widget.isLoading ? null : widget.onPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: content,
              ),
            ),
          ),
        );
      case _ButtonVariant.text:
        button = GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: TextButton(
              onPressed: widget.isLoading ? null : widget.onPressed,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                textStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: content,
            ),
          ),
        );
    }

    if (widget.isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}

enum _ButtonVariant { primary, secondary, text }
