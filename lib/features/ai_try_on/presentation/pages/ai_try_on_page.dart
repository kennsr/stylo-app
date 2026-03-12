import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/body_avatar.dart';
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
  // 0 = upload, 1 = avatar
  int? _selectedInputMode;
  // Avatars loaded from API
  List<BodyAvatar> _avatars = [];
  bool _avatarsLoading = false;
  String? _selectedAvatarId;

  @override
  void initState() {
    super.initState();
    // Pre-load avatars in background
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AiTryOnBloc>().add(const AiTryOnLoadAvatars());
    });
  }

  void _onPhotoSelected(String? base64) {
    setState(() {
      _photoBase64 = base64;
      _selectedAvatarId = null;
      if (base64 != null) _selectedInputMode = 0;
    });
  }

  void _onAvatarSelected(String avatarId) {
    setState(() {
      _selectedAvatarId = avatarId;
      _photoBase64 = null;
    });
  }

  void _onTryOn() {
    if (_photoBase64 == null && _selectedAvatarId == null) return;
    context.read<AiTryOnBloc>().add(
          AiTryOnGenerate(
            productId: widget.productId,
            userPhotoBase64: _photoBase64,
            avatarId: _selectedAvatarId,
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
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
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: context.dividerColor),
        ),
      ),
      body: BlocConsumer<AiTryOnBloc, AiTryOnState>(
        listener: (context, state) {
          // Capture loaded avatars into local state, then reset bloc to initial
          if (state is AiTryOnAvatarsLoaded) {
            setState(() {
              _avatars = state.avatars;
              _avatarsLoading = false;
            });
            // Reset bloc back to Initial so the main UI shows correctly
            context.read<AiTryOnBloc>().add(const AiTryOnReset());
          } else if (state is AiTryOnLoadingAvatars) {
            setState(() => _avatarsLoading = true);
          }
        },
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
          // Initial / avatars loading / after reset: input selection
          return _buildInputSelectionState();
        },
      ),
    );
  }

  // ── Step 1: Input selection ──────────────────────────────────────────────

  Widget _buildInputSelectionState() {
    final canStart = _photoBase64 != null || _selectedAvatarId != null;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
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
                const SizedBox(height: 4),
                Text(
                  'Unggah foto dirimu atau pilih avatar untuk melihat tampilan pakaian',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: context.secondaryTextColor,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
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
                          setState(() {
                            _selectedInputMode = 0;
                            _selectedAvatarId = null;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildOptionCard(
                        index: 1,
                        icon: Icons.grid_view_rounded,
                        title: 'Pilih Avatar',
                        subtitle: 'Avatar siap pakai',
                        isSelected: _selectedInputMode == 1,
                        onTap: () {
                          setState(() {
                            _selectedInputMode = 1;
                            _photoBase64 = null;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Photo upload widget (shown when upload mode selected)
                if (_selectedInputMode == 0)
                  PhotoUploadWidget(onPhotoSelected: _onPhotoSelected),
                if (_selectedInputMode == 1)
                  _buildAvatarGrid(),
                const SizedBox(height: 20),
                // Disclaimer
                _buildDisclaimer(),
              ],
            ),
          ),
        ),
        // Bottom CTA
        Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration: BoxDecoration(
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
              icon: const Icon(Icons.view_in_ar_rounded, size: 20),
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
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
              color:
                  isSelected ? AppColors.accent : context.secondaryTextColor,
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 3),
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

  Widget _buildAvatarGrid() {
    if (_avatarsLoading) {
      return SizedBox(
        height: 180,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.accent,
          ),
        ),
      );
    }

    if (_avatars.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32),
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
            const SizedBox(height: 12),
            Text(
              'Tidak ada avatar tersedia',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Coba lagi nanti',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: context.secondaryTextColor,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: _avatars.length,
      itemBuilder: (context, index) {
        final avatar = _avatars[index];
        final isSelected = _selectedAvatarId == avatar.id;
        return GestureDetector(
          onTap: () => _onAvatarSelected(avatar.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? AppColors.accent : context.borderColor,
                width: isSelected ? 2.5 : 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: avatar.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: context.surfaceColor,
                      child: Center(
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 32,
                          color: context.secondaryTextColor,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: context.surfaceColor,
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 32,
                        color: context.secondaryTextColor,
                      ),
                    ),
                  ),
                  // Selection overlay
                  if (isSelected)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  // Avatar name label
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.65),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Text(
                        avatar.name,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TryOnResultView(result: state.result),
                const SizedBox(height: 20),
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
                          side: BorderSide(color: context.borderColor),
                          padding:
                              const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.download_rounded, size: 18),
                        label: Text(
                          'Simpan',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
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
                          padding:
                              const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.share_rounded, size: 18),
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
                const SizedBox(height: 16),
                _buildDisclaimer(),
              ],
            ),
          ),
        ),
        // Sticky bottom CTA
        Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: context.borderColor),
            ),
          ),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  context.read<AiTryOnBloc>().add(const AiTryOnReset());
                  setState(() {
                    _photoBase64 = null;
                    _selectedAvatarId = null;
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: context.primaryTextColor,
                  side: BorderSide(color: context.borderColor),
                  padding: const EdgeInsets.symmetric(
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
              const SizedBox(width: 12),
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
                    icon: const Icon(Icons.shopping_cart_outlined, size: 18),
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
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          PhotoUploadWidget(onPhotoSelected: _onPhotoSelected),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.error.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: AppColors.error,
                  size: 20,
                ),
                const SizedBox(width: 10),
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
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: (_photoBase64 != null || _selectedAvatarId != null)
                  ? _onTryOn
                  : null,
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
          const SizedBox(height: 16),
          _buildDisclaimer(),
        ],
      ),
    );
  }

  // ── Disclaimer ───────────────────────────────────────────────────────────

  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.all(12),
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
          const SizedBox(width: 8),
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
    _messageTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (mounted) {
        setState(() {
          _messageIndex = (_messageIndex + 1) % _statusMessages.length;
        });
      }
    });
    _progressTimer = Timer.periodic(const Duration(milliseconds: 200), (_) {
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
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large circular progress
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.accent,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Progress percentage
            Text(
              '$_progress%',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 12),
            // Rotating status text
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
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
            const SizedBox(height: 24),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _progress / 100,
                backgroundColor: context.dividerColor,
                valueColor: AlwaysStoppedAnimation<Color>(
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
