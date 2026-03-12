import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';
import '../bloc/ai_try_on_bloc.dart';
import '../bloc/ai_try_on_event.dart';
import '../bloc/ai_try_on_state.dart';
import '../../domain/entities/fit_profile.dart';

class FitProfilePage extends StatefulWidget {
  const FitProfilePage({super.key});

  @override
  State<FitProfilePage> createState() => _FitProfilePageState();
}

class _FitProfilePageState extends State<FitProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _chestController = TextEditingController();
  final _waistController = TextEditingController();
  final _hipsController = TextEditingController();

  bool _isSaving = false;
  bool _isLoading = true;
  String? _recommendedSize;
  String _selectedGender = 'Wanita';
  String _selectedBodyType = 'Regular';

  static const _genderOptions = ['Pria', 'Wanita'];
  static const _bodyTypeOptions = [
    ('slim', 'Slim', Icons.airline_seat_flat_angled_rounded),
    ('regular', 'Regular', Icons.person_rounded),
    ('athletic', 'Athletic', Icons.fitness_center_rounded),
    ('curvy', 'Curvy', Icons.favorite_rounded),
  ];

  @override
  void initState() {
    super.initState();
    // Load existing fit profile
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AiTryOnBloc>().add(const AiTryOnGetFitProfile());
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _chestController.dispose();
    _waistController.dispose();
    _hipsController.dispose();
    super.dispose();
  }

  void _populateFields(FitProfile profile) {
    setState(() {
      _heightController.text = profile.height.toString();
      _weightController.text = profile.weight.toString();
      _chestController.text = profile.chest.toString();
      _waistController.text = profile.waist.toString();
      _hipsController.text = profile.hips.toString();
      _isLoading = false;
      _calculateRecommendation();
    });
  }

  void _calculateRecommendation() {
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

  Future<void> _saveFitProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    // Simulate save delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profil ukuran berhasil disimpan',
            style: GoogleFonts.poppins(fontSize: 13),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: context.primaryTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AiTryOnBloc, AiTryOnState>(
      listener: (context, state) {
        if (state is AiTryOnFitProfileLoaded) {
          _populateFields(state.profile);
        } else if (state is AiTryOnFitProfileError) {
          // No existing profile - start fresh
          setState(() => _isLoading = false);
        }
      },
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: _buildAppBar(),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildForm(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: context.backgroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        color: context.primaryTextColor,
        onPressed: () => Navigator.maybePop(context),
      ),
      title: Text(
        'Profil Ukuran',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: context.primaryTextColor,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: context.dividerColor),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildGenderSection(),
            const SizedBox(height: 24),
            _buildBodyTypeSection(),
            const SizedBox(height: 24),
            _buildMeasurementsSection(),
            if (_recommendedSize != null) ...[
              const SizedBox(height: 24),
              _buildRecommendationCard(),
            ],
            const SizedBox(height: 24),
            _buildTipsCard(),
            const SizedBox(height: 24),
            _buildSaveButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data Ukuran Tubuh',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: context.primaryTextColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Masukkan ukuran tubuhmu untuk rekomendasi ukuran yang tepat',
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: context.secondaryTextColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('Jenis Kelamin'),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: _genderOptions.map((g) {
              final isSelected = _selectedGender == g;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedGender = g),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      g,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? context.primaryTextColor
                            : context.secondaryTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBodyTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('Tipe Tubuh'),
        const SizedBox(height: 10),
        Row(
          children: _bodyTypeOptions.map((entry) {
            final (id, label, icon) = entry;
            final isSelected = _selectedBodyType == label;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedBodyType = label),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.accent.withValues(alpha: 0.06)
                          : context.surfaceColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? AppColors.accent : context.borderColor,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          icon,
                          size: 24,
                          color: isSelected ? AppColors.accent : context.secondaryTextColor,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          label,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected ? AppColors.accent : context.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMeasurementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('Ukuran (cm / kg)'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMeasurementField(
                controller: _heightController,
                label: 'Tinggi Badan',
                suffix: 'cm',
                hint: '165',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMeasurementField(
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
              child: _buildMeasurementField(
                controller: _chestController,
                label: 'Lingkar Dada',
                suffix: 'cm',
                hint: '90',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMeasurementField(
                controller: _waistController,
                label: 'Pinggang',
                suffix: 'cm',
                hint: '70',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildMeasurementField(
          controller: _hipsController,
          label: 'Lingkar Pinggul',
          suffix: 'cm',
          hint: '95',
        ),
      ],
    );
  }

  Widget _buildMeasurementField({
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
      onChanged: (_) => _calculateRecommendation(),
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: context.primaryTextColor,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          fontSize: 13,
          color: context.secondaryTextColor,
        ),
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: 13,
          color: context.borderColor,
        ),
        suffixText: suffix,
        suffixStyle: GoogleFonts.poppins(
          fontSize: 13,
          color: context.secondaryTextColor,
        ),
        filled: true,
        fillColor: context.surfaceColor,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          final parsed = double.tryParse(value);
          if (parsed == null || parsed <= 0) {
            return 'Nilai tidak valid';
          }
        }
        return null;
      },
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: context.primaryTextColor,
      ),
    );
  }

  Widget _buildRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
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
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      size: 14,
                      color: AppColors.accent,
                    ),
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
                const SizedBox(height: 4),
                Text(
                  'Ukuran yang disarankan untuk kamu',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: context.secondaryTextColor,
                  ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline_rounded,
                size: 16,
                color: AppColors.warning,
              ),
              const SizedBox(width: 6),
              Text(
                'Tips Mengukur',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: context.primaryTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 5,
                      height: 5,
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

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _isSaving ? null : _saveFitProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: _isSaving
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              )
            : Text(
                'Simpan',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
