import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';

class PhotoUploadWidget extends StatefulWidget {
  final ValueChanged<String?> onPhotoSelected;

  const PhotoUploadWidget({super.key, required this.onPhotoSelected});

  @override
  State<PhotoUploadWidget> createState() => _PhotoUploadWidgetState();
}

class _PhotoUploadWidgetState extends State<PhotoUploadWidget> {
  String? _imagePath;
  String? _photoBase64;
  final ImagePicker _picker = ImagePicker();

  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: context.borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Pilih Foto',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: context.primaryTextColor,
                    ),
                  ),
                ),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.accent,
                    ),
                  ),
                  title: Text(
                    'Kamera',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: context.primaryTextColor,
                    ),
                  ),
                  subtitle: Text(
                    'Ambil foto langsung',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: context.secondaryTextColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.photo_library_rounded,
                      color: AppColors.info,
                    ),
                  ),
                  title: Text(
                    'Galeri',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: context.primaryTextColor,
                    ),
                  ),
                  subtitle: Text(
                    'Pilih dari galeri foto',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: context.secondaryTextColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                if (_photoBase64 != null)
                  ListTile(
                    leading: Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                    ),
                    title: Text(
                      'Hapus Foto',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.error,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _removePhoto();
                    },
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      // Check if the source is available
      if (source == ImageSource.camera) {
        final cameras = await availableCameras();
        if (cameras.isEmpty) {
          _showError('Kamera tidak tersedia di perangkat ini. Silakan gunakan galeri.');
          return;
        }
      }
      
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 640,  // Further reduced to prevent 413 errors
        maxHeight: 640,
        imageQuality: 70,  // Further reduced for smaller file size
      );

      if (pickedFile != null && mounted) {
        // Read file as bytes and convert to base64
        final bytes = await File(pickedFile.path).readAsBytes();
        
        // Check file size (max 1MB to prevent 413 errors on server)
        // Base64 adds ~33% overhead, so 1MB binary = ~1.33MB base64
        const maxFileSize = 1 * 1024 * 1024; // 1MB
        if (bytes.length > maxFileSize) {
          _showError('Ukuran foto terlalu besar (${(bytes.length / 1024 / 1024).toStringAsFixed(1)}MB). Silakan pilih foto dengan ukuran kurang dari 1MB.');
          return;
        }
        
        final base64Image = base64Encode(bytes);
        
        // Debug: Log the actual sizes (only in debug mode)
        assert(() {
          print('📸 Image uploaded:'); // ignore: avoid_print
          print('   - File size: ${(bytes.length / 1024).toStringAsFixed(1)} KB'); // ignore: avoid_print
          print('   - Base64 size: ${(base64Image.length / 1024).toStringAsFixed(1)} KB'); // ignore: avoid_print
          print('   - Max server limit: ~1MB binary / ~1.33MB base64'); // ignore: avoid_print
          return true;
        }());

        setState(() {
          _imagePath = pickedFile.path;
          _photoBase64 = base64Image;
        });

        widget.onPhotoSelected(base64Image);

        // Show success feedback
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Foto berhasil dipilih',
                style: GoogleFonts.poppins(fontSize: 13),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.success,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      } else if (mounted && source == ImageSource.camera) {
        // Camera was cancelled or failed - suggest using gallery
        _showInfo('Tidak dapat mengakses kamera. Silakan gunakan galeri foto.');
      }
    } on CameraException catch (e) {
      // Camera-specific error
      if (mounted) {
        if (e.code == 'cameraPermission') {
          _showError('Izin kamera ditolak. Silakan aktifkan di pengaturan perangkat.');
        } else if (e.code == 'cameraUnavailable') {
          _showError('Kamera tidak tersedia. Silakan gunakan galeri foto.');
        } else {
          _showError('Gagal mengakses kamera.');
        }
      }
    } catch (e) {
      // Handle permission denied or other errors
      if (mounted) {
        final errorMsg = e.toString().toLowerCase();
        if (errorMsg.contains('permission') || errorMsg.contains('denied')) {
          _showError('Izin kamera/galeri ditolak. Silakan aktifkan di pengaturan perangkat.');
        } else if (errorMsg.contains('camera')) {
          _showError('Kamera tidak tersedia. Silakan gunakan galeri foto.');
        } else {
          _showError('Gagal memilih foto. Pastikan izin kamera/galeri sudah diberikan.');
        }
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.error,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        action: SnackBarAction(
          label: 'Galeri',
          textColor: Colors.white,
          onPressed: () {
            // Don't use Navigator.pop - the sheet might already be closed
            // Just directly open gallery
            _pickImage(ImageSource.gallery);
          },
        ),
      ),
    );
  }

  void _showInfo(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.info,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removePhoto() {
    setState(() {
      _imagePath = null;
      _photoBase64 = null;
    });
    widget.onPhotoSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: _photoBase64 == null ? _showUploadOptions : null,
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _photoBase64 != null ? AppColors.accent : context.borderColor,
            width: _photoBase64 != null ? 2 : 1.5,
          ),
        ),
        child: _photoBase64 != null
            ? Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: AppColors.accent.withValues(alpha: 0.08),
                      child: _imagePath != null
                          ? Image.file(
                              File(_imagePath!),
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: Icon(
                                Icons.person,
                                size: 80,
                                color: AppColors.accent,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: _removePhoto,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Foto terpilih',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.accent,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Unggah Foto Kamu',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.primaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Pilih dari kamera atau galeri',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _showUploadOptions,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      side: const BorderSide(color: AppColors.accent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.upload, size: 18),
                    label: const Text('Pilih Foto'),
                  ),
                ],
              ),
      ),
    );
  }
}
