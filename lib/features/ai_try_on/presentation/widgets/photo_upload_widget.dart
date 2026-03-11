import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';

class PhotoUploadWidget extends StatefulWidget {
  final ValueChanged<String?> onPhotoSelected;

   const PhotoUploadWidget({super.key, required this.onPhotoSelected});

  @override
  State<PhotoUploadWidget> createState() => _PhotoUploadWidgetState();
}

class _PhotoUploadWidgetState extends State<PhotoUploadWidget> {
  // unused field removed
  bool _hasPhoto = false;

  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin:  EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: context.borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Pilih Foto',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    child:  Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.accent,
                    ),
                  ),
                  title:  Text('Kamera'),
                  subtitle:  Text('Ambil foto langsung'),
                  onTap: () {
                    Navigator.pop(context);
                    _mockSelectPhoto('kamera');
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
                    child:  Icon(
                      Icons.photo_library_rounded,
                      color: AppColors.info,
                    ),
                  ),
                  title:  Text('Galeri'),
                  subtitle:  Text('Pilih dari galeri foto'),
                  onTap: () {
                    Navigator.pop(context);
                    _mockSelectPhoto('galeri');
                  },
                ),
                 SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _mockSelectPhoto(String source) {
    // Mock: simulate photo selection with a placeholder base64 string
    const mockBase64 =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==';
    setState(() {
      _hasPhoto = true;
    });
    widget.onPhotoSelected(mockBase64);
  }

  void _removePhoto() {
    setState(() {
      _hasPhoto = false;
    });
    widget.onPhotoSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: _hasPhoto ? null : _showUploadOptions,
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hasPhoto ? AppColors.accent : context.borderColor,
            width: _hasPhoto ? 2 : 1.5,
          ),
        ),
        child: _hasPhoto
            ? Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: AppColors.accent.withValues(alpha: 0.08),
                      child:  Center(
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
                        padding:  EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child:  Icon(
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
                        padding:  EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  Text(
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
                    child:  Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.accent,
                      size: 32,
                    ),
                  ),
                   SizedBox(height: 16),
                  Text(
                    'Unggah Foto Kamu',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.primaryTextColor,
                    ),
                  ),
                   SizedBox(height: 6),
                  Text(
                    'Pilih dari kamera atau galeri',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.secondaryTextColor,
                    ),
                  ),
                   SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _showUploadOptions,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      side:  BorderSide(color: AppColors.accent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon:  Icon(Icons.upload, size: 18),
                    label:  Text('Pilih Foto'),
                  ),
                ],
              ),
      ),
    );
  }
}
