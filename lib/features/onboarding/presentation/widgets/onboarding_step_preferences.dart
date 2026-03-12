import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingStepPreferences extends StatefulWidget {
  final ValueChanged<bool> onCanProceedChanged;

  const OnboardingStepPreferences({
    super.key,
    required this.onCanProceedChanged,
  });

  @override
  State<OnboardingStepPreferences> createState() =>
      _OnboardingStepPreferencesState();
}

class _OnboardingStepPreferencesState
    extends State<OnboardingStepPreferences> {
  final Set<String> _selected = {};

  // Maps preference label → emoji icon
  static const _icons = {
    'Batik': '🧵',
    'Streetwear': '👟',
    'Modest': '🧕',
    'Kasual': '👕',
    'Formal': '👔',
    'Minimalis': '⬜',
    'Bohemian': '🌸',
    'Vintage': '🎞️',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onCanProceedChanged(false);
    });
  }

  void _toggle(String pref) {
    setState(() {
      if (_selected.contains(pref)) {
        _selected.remove(pref);
      } else {
        _selected.add(pref);
      }
    });
    widget.onCanProceedChanged(_selected.isNotEmpty);
    context.read<OnboardingCubit>().setPreferences(_selected.toList());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.style_outlined,
                size: 44,
                color: AppColors.accent,
              ),
            ),
          ),
          const SizedBox(height: 28),

          Text(
            'Gaya favoritmu?',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: context.primaryTextColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Pilih satu atau lebih gaya fashion yang kamu suka. Kami akan merekomendasikan produk yang sesuai.',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: context.secondaryTextColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // Selection hint
          Row(
            children: [
              const Icon(Icons.check_circle_outline_rounded,
                  size: 15, color: AppColors.accent),
              const SizedBox(width: 6),
              Text(
                '${_selected.length} dipilih',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _selected.isEmpty
                      ? context.secondaryTextColor
                      : AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.4,
            ),
            itemCount: AppConstants.stylePreferences.length,
            itemBuilder: (context, index) {
              final pref = AppConstants.stylePreferences[index];
              final isSelected = _selected.contains(pref);
              final emoji = _icons[pref] ?? '✨';

              return GestureDetector(
                onTap: () => _toggle(pref),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accent
                        : context.surfaceColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.accent
                          : context.borderColor,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(emoji, style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      Text(
                        pref,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? Colors.white
                              : context.primaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
