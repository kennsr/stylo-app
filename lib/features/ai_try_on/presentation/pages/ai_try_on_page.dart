import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/ai_try_on_bloc.dart';
import '../bloc/ai_try_on_event.dart';
import '../bloc/ai_try_on_state.dart';
import '../widgets/photo_upload_widget.dart';
import '../widgets/try_on_result_view.dart';
import '../../../../core/theme/theme_ext.dart';

class AiTryOnPage extends StatefulWidget {
  final String productId;

   const AiTryOnPage({super.key, required this.productId});

  @override
  State<AiTryOnPage> createState() => _AiTryOnPageState();
}

class _AiTryOnPageState extends State<AiTryOnPage> {
  String? _photoBase64;
  // 0 = upload, 1 = avatar (placeholder)
  int? _selectedInputMode;

  void _onPhotoSelected(String? base64) {
    setState(() {
      _photoBase64 = base64;
      if (base64 != null) _selectedInputMode = 0;
    });
  }

  void _onTryOn() {
    if (_photoBase64 == null) return;
    context.read<AiTryOnBloc>().add(
          AiTryOnGenerate(
            productId: widget.productId,
            userPhotoBase64: _photoBase64!,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: context.primaryTextColor,
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'AI Virtual Try-On',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: context.primaryTextColor,
          ),
        ),
        bottom: PreferredSize(
          preferredSize:  Size.fromHeight(1),
          child: Container(height: 1, color: context.dividerColor),
        ),
      ),
      body: BlocBuilder<AiTryOnBloc, AiTryOnState>(
        builder: (context, state) {
          if (state is AiTryOnGenerating) {
            return _buildProcessingState();
          }
          if (state is AiTryOnSuccess) {
            return _buildResultState(state);
          }
          if (state is AiTryOnError) {
            return _buildErrorState(state.message);
          }
          // Initial / default: input selection
          return _buildInputSelectionState();
        },
      ),
    );
  }

  // ── Step 1: Input selection ──────────────────────────────────────────────

  Widget _buildInputSelectionState() {
    final canStart = _photoBase64 != null;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding:  EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Instruction
                Text(
                  'Pilih Cara Mencoba',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: context.primaryTextColor,
                  ),
                ),
                 SizedBox(height: 4),
                Text(
                  'Unggah foto dirimu atau pilih avatar untuk melihat tampilan pakaian',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: context.secondaryTextColor,
                    height: 1.5,
                  ),
                ),
                 SizedBox(height: 20),
                // Two option cards side by side
                Row(
                  children: [
                    Expanded(
                      child: _buildOptionCard(
                        index: 0,
                        icon: Icons.cloud_upload_outlined,
                        title: 'Unggah Foto',
                        subtitle: 'Foto kamu sendiri',
                        isSelected: _selectedInputMode == 0,
                        onTap: () {
                          setState(() => _selectedInputMode = 0);
                        },
                      ),
                    ),
                     SizedBox(width: 12),
                    Expanded(
                      child: _buildOptionCard(
                        index: 1,
                        icon: Icons.grid_view_rounded,
                        title: 'Pilih Avatar',
                        subtitle: 'Avatar siap pakai',
                        isSelected: _selectedInputMode == 1,
                        onTap: () {
                          setState(() => _selectedInputMode = 1);
                        },
                      ),
                    ),
                  ],
                ),
                 SizedBox(height: 20),
                // Photo upload widget (shown when upload mode selected)
                if (_selectedInputMode == 0)
                  PhotoUploadWidget(onPhotoSelected: _onPhotoSelected),
                if (_selectedInputMode == 1)
                  _buildAvatarPlaceholder(),
                 SizedBox(height: 20),
                // Disclaimer
                _buildDisclaimer(),
              ],
            ),
          ),
        ),
        // Bottom CTA
        Container(
          padding:  EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration:  BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: context.borderColor),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: canStart ? _onTryOn : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                disabledBackgroundColor: context.borderColor,
                disabledForegroundColor: context.secondaryTextColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon:  Icon(Icons.view_in_ar_rounded, size: 20),
              label: Text(
                'Mulai Coba',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:  Duration(milliseconds: 180),
        padding:  EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent.withValues(alpha: 0.06)
              : context.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.accent : context.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 36,
              color: isSelected ? AppColors.accent : context.secondaryTextColor,
            ),
             SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppColors.accent
                    : context.primaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 3),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: context.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        children: [
          Icon(
            Icons.person_outlined,
            size: 48,
            color: Colors.grey.shade300,
          ),
           SizedBox(height: 12),
          Text(
            'Pilih Avatar',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.primaryTextColor,
            ),
          ),
           SizedBox(height: 4),
          Text(
            'Fitur segera hadir',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: context.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  // ── Step 2: Processing ───────────────────────────────────────────────────

  Widget _buildProcessingState() {
    return _ProcessingView();
  }

  // ── Step 3: Result ───────────────────────────────────────────────────────

  Widget _buildResultState(AiTryOnSuccess state) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding:  EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TryOnResultView(result: state.result),
                 SizedBox(height: 20),
                // Save and share buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Gambar disimpan',
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: context.primaryTextColor,
                          side:  BorderSide(color: context.borderColor),
                          padding:  EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon:  Icon(Icons.download_rounded, size: 18),
                        label: Text(
                          'Simpan',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                     SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Bagikan gambar',
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding:  EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon:  Icon(Icons.share_rounded, size: 18),
                        label: Text(
                          'Bagikan',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                 SizedBox(height: 16),
                _buildDisclaimer(),
              ],
            ),
          ),
        ),
        // Sticky bottom CTA
        Container(
          padding:  EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration:  BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: context.borderColor),
            ),
          ),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  context.read<AiTryOnBloc>().add( AiTryOnReset());
                  setState(() => _photoBase64 = null);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: context.primaryTextColor,
                  side:  BorderSide(color: context.borderColor),
                  padding:  EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Coba Lagi',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
               SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Ditambahkan ke keranjang',
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon:  Icon(Icons.shopping_cart_outlined, size: 18),
                    label: Text(
                      'Tambah ke Keranjang',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Error state ──────────────────────────────────────────────────────────

  Widget _buildErrorState(String message) {
    return Padding(
      padding:  EdgeInsets.all(20),
      child: Column(
        children: [
          PhotoUploadWidget(onPhotoSelected: _onPhotoSelected),
           SizedBox(height: 16),
          Container(
            padding:  EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.error.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              children: [
                 Icon(
                  Icons.error_outline_rounded,
                  color: AppColors.error,
                  size: 20,
                ),
                 SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
           SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _photoBase64 != null ? _onTryOn : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Coba Lagi',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
           SizedBox(height: 16),
          _buildDisclaimer(),
        ],
      ),
    );
  }

  // ── Disclaimer ───────────────────────────────────────────────────────────

  Widget _buildDisclaimer() {
    return Container(
      padding:  EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Icon(
            Icons.info_outline_rounded,
            size: 15,
            color: context.secondaryTextColor,
          ),
           SizedBox(width: 8),
          Expanded(
            child: Text(
              '* Gambar dihasilkan oleh AI, hanya sebagai visualisasi',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: context.secondaryTextColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Processing animation widget ──────────────────────────────────────────────

class _ProcessingView extends StatefulWidget {
  @override
  State<_ProcessingView> createState() => _ProcessingViewState();
}

class _ProcessingViewState extends State<_ProcessingView> {
  static const _statusMessages = [
    'Menganalisis foto kamu...',
    'Memproses model pakaian...',
    'Menggabungkan elemen visual...',
    'Menyempurnakan hasil try-on...',
    'Hampir selesai...',
  ];

  int _messageIndex = 0;
  int _progress = 0;
  Timer? _messageTimer;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    _messageTimer = Timer.periodic( Duration(seconds: 2), (_) {
      if (mounted) {
        setState(() {
          _messageIndex = (_messageIndex + 1) % _statusMessages.length;
        });
      }
    });
    _progressTimer = Timer.periodic( Duration(milliseconds: 200), (_) {
      if (mounted && _progress < 95) {
        setState(() => _progress += 2);
      }
    });
  }

  @override
  void dispose() {
    _messageTimer?.cancel();
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large circular progress
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 3,
                valueColor:  AlwaysStoppedAnimation<Color>(
                  AppColors.accent,
                ),
              ),
            ),
             SizedBox(height: 32),
            // Progress percentage
            Text(
              '$_progress%',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: context.primaryTextColor,
              ),
            ),
             SizedBox(height: 12),
            // Rotating status text
            AnimatedSwitcher(
              duration:  Duration(milliseconds: 400),
              child: Text(
                _statusMessages[_messageIndex],
                key: ValueKey(_messageIndex),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
             SizedBox(height: 24),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _progress / 100,
                backgroundColor: context.dividerColor,
                valueColor:  AlwaysStoppedAnimation<Color>(
                  AppColors.accent,
                ),
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
