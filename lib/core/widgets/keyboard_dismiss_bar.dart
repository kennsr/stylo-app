import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/theme_ext.dart';

/// Global overlay that shows a floating "close keyboard" button just above
/// the software keyboard whenever it is visible. Wrap [MaterialApp.builder]
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
          bottom: isVisible ? bottomInset + 16 : -60,
          right: 16,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 160),
            opacity: isVisible ? 1.0 : 0.0,
            child: const _DismissFloatingButton(),
          ),
        ),
      ],
    );
  }
}

class _DismissFloatingButton extends StatelessWidget {
  const _DismissFloatingButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.dividerColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.keyboard_hide_rounded,
              size: 20,
              color: AppColors.accent,
            ),
          ),
        ),
      ),
    );
  }
}
