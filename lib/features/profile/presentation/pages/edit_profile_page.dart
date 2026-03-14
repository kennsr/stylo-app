import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  bool _isSaving = false;
  bool _controllersSeeded = false;
  String? _avatarLocalPath;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileBloc>().state;
    if (state is ProfileLoaded) {
      _controllersSeeded = true;
      _nameController = TextEditingController(text: state.user.name);
      _phoneController = TextEditingController(text: state.user.phone ?? '');
      _avatarLocalPath = state.user.avatarUrl;
    } else {
      _nameController = TextEditingController();
      _phoneController = TextEditingController();
    }
  }

  void _seedControllers(ProfileLoaded state) {
    if (_controllersSeeded) return;
    _controllersSeeded = true;
    _nameController.text = state.user.name;
    _phoneController.text = state.user.phone ?? '';
    _avatarLocalPath = state.user.avatarUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
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
        setState(() => _avatarLocalPath = picked.path);
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
              if (_avatarLocalPath != null && !_avatarLocalPath!.startsWith('http'))
                ListTile(
                  leading: Icon(Icons.delete_outline, color: AppColors.error),
                  title: Text(
                    'Hapus Foto',
                    style: GoogleFonts.poppins(fontSize: 14, color: AppColors.error),
                  ),
                  onTap: () {
                    setState(() => _avatarLocalPath = null);
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    // If avatar was changed, upload it first
    if (_avatarLocalPath != null && !_avatarLocalPath!.startsWith('http')) {
      context.read<ProfileBloc>().add(
        ProfileUploadAvatar(avatarFile: File(_avatarLocalPath!)),
      );
    }

    context.read<ProfileBloc>().add(
      ProfileUpdate(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdating) {
          setState(() => _isSaving = true);
        } else if (state is ProfileLoaded) {
          if (_isSaving) {
            setState(() => _isSaving = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profil berhasil diperbarui ✨'),
                backgroundColor: AppColors.success,
              ),
            );
            Navigator.of(context).pop();
          } else {
            _seedControllers(state);
          }
        } else if (state is ProfileError) {
          setState(() => _isSaving = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profil'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar section
                Center(
                  child: GestureDetector(
                    onTap: _showPickerSheet,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.surfaceColor,
                            border: Border.all(
                              color: _avatarLocalPath != null
                                  ? AppColors.primary
                                  : context.borderColor,
                              width: _avatarLocalPath != null ? 2.5 : 1.5,
                            ),
                          ),
                          child: ClipOval(
                            child: _avatarLocalPath != null
                                ? (_avatarLocalPath!.startsWith('http')
                                    ? Image.network(
                                        _avatarLocalPath!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, _, _) => _DefaultAvatar(),
                                      )
                                    : Image.file(
                                        File(_avatarLocalPath!),
                                        fit: BoxFit.cover,
                                      ))
                                : _DefaultAvatar(),
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    _avatarLocalPath != null
                        ? 'Ketuk untuk ganti foto'
                        : 'Tambah foto profil',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: context.secondaryTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Name field
                Text(
                  'Nama',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama lengkap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: context.surfaceHighColor,
                    prefixIcon: Icon(Icons.person_outline, color: context.tertiaryTextColor),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Phone field
                Text(
                  'Nomor HP',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 081234567890',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: context.surfaceHighColor,
                    prefixIcon: Icon(Icons.phone_outlined, color: context.tertiaryTextColor),
                  ),
                ),
                const SizedBox(height: 32),

                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Simpan Perubahan',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              letterSpacing: 0.3,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      size: 50,
      color: AppColors.primary.withValues(alpha: 0.3),
    );
  }
}
