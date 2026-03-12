import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';

/// Data class holding validated fit profile values from the form.
class FitProfileData {
  final double height;
  final double weight;
  final double chest;
  final double waist;
  final double hips;
  final String preferredSize;

  const FitProfileData({
    required this.height,
    required this.weight,
    required this.chest,
    required this.waist,
    required this.hips,
    required this.preferredSize,
  });
}

class OnboardingStepFit extends StatefulWidget {
  final ValueChanged<bool> onCanProceedChanged;
  final ValueChanged<FitProfileData?> onFitDataChanged;

  const OnboardingStepFit({
    super.key,
    required this.onCanProceedChanged,
    required this.onFitDataChanged,
  });

  @override
  State<OnboardingStepFit> createState() => _OnboardingStepFitState();
}

class _OnboardingStepFitState extends State<OnboardingStepFit> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _chestController = TextEditingController();
  final _waistController = TextEditingController();
  final _hipsController = TextEditingController();

  String? _selectedSize;
  String? _recommendedSize;

  static const _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  @override
  void initState() {
    super.initState();
    for (final c in _controllers) {
      c.addListener(_onChanged);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onCanProceedChanged(false);
    });
  }

  List<TextEditingController> get _controllers => [
        _heightController,
        _weightController,
        _chestController,
        _waistController,
        _hipsController,
      ];

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onChanged() {
    _updateRecommendedSize();
    _validate();
  }

  void _updateRecommendedSize() {
    final chest = double.tryParse(_chestController.text);
    if (chest == null) {
      setState(() => _recommendedSize = null);
      return;
    }
    String size;
    if (chest < 82) {
      size = 'XS';
    } else if (chest < 88) {
      size = 'S';
    } else if (chest < 96) {
      size = 'M';
    } else if (chest < 104) {
      size = 'L';
    } else if (chest < 112) {
      size = 'XL';
    } else {
      size = 'XXL';
    }
    setState(() => _recommendedSize = size);
  }

  void _selectSize(String size) {
    setState(() => _selectedSize = size);
    _validate();
  }

  void _validate() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);
    final chest = double.tryParse(_chestController.text);
    final waist = double.tryParse(_waistController.text);
    final hips = double.tryParse(_hipsController.text);

    final valid = height != null &&
        height > 0 &&
        weight != null &&
        weight > 0 &&
        chest != null &&
        chest > 0 &&
        waist != null &&
        waist > 0 &&
        hips != null &&
        hips > 0 &&
        _selectedSize != null;

    widget.onCanProceedChanged(valid);
    widget.onFitDataChanged(
      valid
          ? FitProfileData(
              // Dart flow analysis promotes local double? vars to double
              // inside the `valid == true` branch since the &&-chain above
              // already null-checked and range-checked each of them.
              height: height,
              weight: weight,
              chest: chest,
              waist: waist,
              hips: hips,
              preferredSize: _selectedSize!,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header icon
          Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.straighten_rounded,
                size: 44,
                color: AppColors.accent,
              ),
            ),
          ),
          const SizedBox(height: 28),

          Text(
            'Profil ukuranmu',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: context.primaryTextColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Bantu kami merekomendasikan ukuran yang pas untukmu. Semua data aman dan hanya digunakan untuk rekomendasi.',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: context.secondaryTextColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),

          // Measurements
          _sectionLabel('Ukuran Tubuh'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _measurementField(
                  controller: _heightController,
                  label: 'Tinggi Badan',
                  suffix: 'cm',
                  hint: '165',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _measurementField(
                  controller: _weightController,
                  label: 'Berat Badan',
                  suffix: 'kg',
                  hint: '55',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _measurementField(
                  controller: _chestController,
                  label: 'Lingkar Dada',
                  suffix: 'cm',
                  hint: '90',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _measurementField(
                  controller: _waistController,
                  label: 'Pinggang',
                  suffix: 'cm',
                  hint: '70',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _measurementField(
            controller: _hipsController,
            label: 'Lingkar Pinggul',
            suffix: 'cm',
            hint: '95',
          ),
          const SizedBox(height: 24),

          // Recommendation card
          if (_recommendedSize != null) ...[
            _buildRecommendationCard(),
            const SizedBox(height: 24),
          ],

          // Size selector
          _sectionLabel('Ukuran Pilihan *'),
          const SizedBox(height: 4),
          Text(
            'Pilih ukuran yang biasa kamu pakai',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: context.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _sizes.map((size) {
              final isSelected = _selectedSize == size;
              final isRecommended = _recommendedSize == size;
              return GestureDetector(
                onTap: () => _selectSize(size),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 56,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accent
                        : isRecommended
                            ? AppColors.accent.withValues(alpha: 0.06)
                            : context.surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.accent
                          : isRecommended
                              ? AppColors.accent
                              : context.borderColor,
                      width: isSelected || isRecommended ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        size,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : isRecommended
                                  ? AppColors.accent
                                  : context.primaryTextColor,
                        ),
                      ),
                      if (isRecommended && !isSelected)
                        Text(
                          'AI',
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Tips card
          _buildTipsCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: context.primaryTextColor,
      ),
    );
  }

  Widget _measurementField({
    required TextEditingController controller,
    required String label,
    required String suffix,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
      ],
      style: GoogleFonts.poppins(fontSize: 14, color: context.primaryTextColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
            fontSize: 12, color: context.secondaryTextColor),
        hintText: hint,
        hintStyle:
            GoogleFonts.poppins(fontSize: 13, color: context.borderColor),
        suffixText: suffix,
        suffixStyle: GoogleFonts.poppins(
            fontSize: 12, color: context.secondaryTextColor),
        filled: true,
        fillColor: context.surfaceColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                _recommendedSize!,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.auto_awesome_rounded,
                        size: 13, color: AppColors.accent),
                    const SizedBox(width: 4),
                    Text(
                      'Rekomendasi AI',
                      style: GoogleFonts.poppins(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Berdasarkan lingkar dada kamu',
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: context.secondaryTextColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsCard() {
    final tips = [
      'Ukur lingkar dada di bagian terlebar',
      'Ukur lingkar pinggang di bagian terkecil',
      'Ukur lingkar pinggul di bagian terlebar',
      'Gunakan pita ukur yang fleksibel',
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline_rounded,
                  size: 15, color: AppColors.warning),
              const SizedBox(width: 6),
              Text(
                'Tips Mengukur',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: context.primaryTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: context.secondaryTextColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      tip,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: context.secondaryTextColor,
                        height: 1.5,
                      ),
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
