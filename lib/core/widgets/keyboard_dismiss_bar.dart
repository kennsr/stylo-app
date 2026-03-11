import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/theme_ext.dart';

/// Global overlay that shows a "close keyboard" toolbar just above the
/// software keyboard whenever it is visible. Wrap [MaterialApp.builder]
/// with this widget.
class KeyboardDismissBar extends StatelessWidget {
  final Widget child;

  const KeyboardDismissBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isVisible = bottomInset > 80;

    return Stack(
      children: [
        Positioned.fill(child: child),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          bottom: isVisible ? bottomInset : -48,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 160),
            opacity: isVisible ? 1.0 : 0.0,
            child: const _DismissToolbar(),
          ),
        ),
      ],
    );
  }
}

class _DismissToolbar extends StatelessWidget {
  const _DismissToolbar();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: context.backgroundColor,
          border: Border(
            top: BorderSide(color: context.dividerColor, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Dismiss button
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_hide_rounded,
                      size: 18,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Tutup',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
