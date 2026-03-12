import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingStepProfile extends StatefulWidget {
  final String initialName;
  final ValueChanged<bool> onCanProceedChanged;

  const OnboardingStepProfile({
    super.key,
    required this.initialName,
    required this.onCanProceedChanged,
  });

  @override
  State<OnboardingStepProfile> createState() => _OnboardingStepProfileState();
}

class _OnboardingStepProfileState extends State<OnboardingStepProfile> {
  late final TextEditingController _nameController;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _nameController.addListener(_onChanged);
    _phoneController.addListener(_onChanged);

    // Initialise can-proceed and cubit after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncToCubit();
      widget.onCanProceedChanged(_nameController.text.trim().isNotEmpty);
    });
  }

  void _onChanged() {
    widget.onCanProceedChanged(_nameController.text.trim().isNotEmpty);
    _syncToCubit();
  }

  void _syncToCubit() {
    final phone = _phoneController.text.trim();
    context.read<OnboardingCubit>().setProfileData(
          _nameController.text.trim(),
          phone.isEmpty ? null : phone,
        );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Illustration / icon
          Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                size: 44,
                color: AppColors.accent,
              ),
            ),
          ),
          const SizedBox(height: 28),

          Text(
            'Siapa namamu?',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: context.primaryTextColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Lengkapi identitas akunmu agar pengalaman belanjamu lebih personal.',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: context.secondaryTextColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Name field
          _buildLabel('Nama Lengkap *'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: context.primaryTextColor,
            ),
            decoration: _inputDecoration(
              context,
              hint: 'Masukkan nama lengkap',
              prefixIcon: Icons.badge_outlined,
            ),
          ),
          const SizedBox(height: 20),

          // Phone field
          _buildLabel('Nomor HP'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: context.primaryTextColor,
            ),
            decoration: _inputDecoration(
              context,
              hint: 'Contoh: 08123456789',
              prefixIcon: Icons.phone_outlined,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Opsional — digunakan untuk notifikasi pesanan',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: context.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: context.primaryTextColor,
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String hint,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: context.secondaryTextColor,
      ),
      prefixIcon: Icon(prefixIcon, size: 20, color: context.secondaryTextColor),
      filled: true,
      fillColor: context.surfaceColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
    );
  }
}
