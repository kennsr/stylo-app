import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingStepAvatar extends StatefulWidget {
  final ValueChanged<bool> onCanProceedChanged;

  const OnboardingStepAvatar({
    super.key,
    required this.onCanProceedChanged,
  });

  @override
  State<OnboardingStepAvatar> createState() => _OnboardingStepAvatarState();
}

class _OnboardingStepAvatarState extends State<OnboardingStepAvatar> {
  String? _imagePath;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Avatar step can always proceed (photo is optional)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onCanProceedChanged(true);
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (picked != null && mounted) {
        setState(() => _imagePath = picked.path);
        context.read<OnboardingCubit>().setAvatar(picked.path);
      }
    } catch (_) {
      // Permission denied or cancelled — ignore
    }
    if (mounted) Navigator.of(context).pop();
  }

  void _showPickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: context.borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(
                  'Pilih dari Galeri',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                onTap: () => _pickImage(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(
                  'Ambil Foto',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                onTap: () => _pickImage(ImageSource.camera),
              ),
              if (_imagePath != null)
                ListTile(
                  leading: Icon(Icons.delete_outline,
                      color: AppColors.error),
                  title: Text(
                    'Hapus Foto',
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: AppColors.error),
                  ),
                  onTap: () {
                    setState(() => _imagePath = null);
                    context.read<OnboardingCubit>().setAvatar(null);
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          Text(
            'Tambah foto profil',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: context.primaryTextColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Foto profilmu membantu penjual mengenalmu. Ini opsional dan bisa diubah nanti.',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: context.secondaryTextColor,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Avatar circle
          GestureDetector(
            onTap: _showPickerSheet,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.surfaceColor,
                    border: Border.all(
                      color: _imagePath != null
                          ? AppColors.accent
                          : context.borderColor,
                      width: _imagePath != null ? 2.5 : 1.5,
                    ),
                  ),
                  child: ClipOval(
                    child: _imagePath != null
                        ? Image.file(
                            File(_imagePath!),
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person_rounded,
                            size: 60,
                            color: context.secondaryTextColor,
                          ),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text(
            _imagePath != null ? 'Foto dipilih ✓' : 'Ketuk untuk memilih foto',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight:
                  _imagePath != null ? FontWeight.w600 : FontWeight.w400,
              color: _imagePath != null
                  ? AppColors.success
                  : context.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 40),

          // Info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded,
                    size: 18, color: AppColors.info),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Kamu bisa melewati langkah ini dan menambahkan foto profil nanti di halaman Profil.',
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
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
