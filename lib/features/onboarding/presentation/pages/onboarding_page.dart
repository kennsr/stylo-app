import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';
import '../../../../core/widgets/stylo_svg_icon.dart';
import '../../../../core/widgets/stylo_button.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/onboarding_step_avatar.dart';
import '../widgets/onboarding_step_fit.dart';
import '../widgets/onboarding_step_preferences.dart';
import '../widgets/onboarding_step_profile.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();

  int _step = 0;
  bool _canProceed = false;
  FitProfileData? _fitData;

  static const _totalSteps = 4;

  static const _stepTitles = [
    'Identitas',
    'Gaya Fashion',
    'Foto Profil',
    'Profil Ukuran',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onCanProceedChanged(bool value) {
    if (_canProceed != value) {
      setState(() => _canProceed = value);
    }
  }

  void _onFitDataChanged(FitProfileData? data) {
    _fitData = data;
  }

  void _onNext() {
    final cubit = context.read<OnboardingCubit>();

    if (_step < _totalSteps - 1) {
      // Close keyboard when moving from profile step (index 0) to avatar step
      if (_step == 0) {
        FocusScope.of(context).unfocus();
      }
      // Advance to next step
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() {
        _step++;
        // Avatar step (index 2) is always enabled
        _canProceed = _step == 2;
      });
    } else {
      // Final step — submit
      if (_fitData != null) {
        final authState = context.read<AuthBloc>().state;
        final userId =
            authState is AuthAuthenticated ? authState.user.id : '';
        cubit.submitOnboarding(
          userId: userId,
          height: _fitData!.height,
          weight: _fitData!.weight,
          chest: _fitData!.chest,
          waist: _fitData!.waist,
          hips: _fitData!.hips,
          preferredSize: _fitData!.preferredSize,
        );
      }
    }
  }

  String get _initialName {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) return authState.user.name;
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // If trying to pop and there's an error, allow navigation to login
        if (!didPop) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state.isComplete) {
            context.go('/home');
          } else if (state.error != null) {
            // Show error with option to go back to login
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error!,
                  style: GoogleFonts.poppins(fontSize: 13),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                action: SnackBarAction(
                  label: 'Login',
                  textColor: Colors.white,
                  onPressed: () {
                    context.go('/login');
                  },
                ),
                duration: const Duration(seconds: 5),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.backgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  // ── Header ──────────────────────────────────────────────
                  _buildHeader(),

                  // ── Progress bar ─────────────────────────────────────────
                  _buildProgressBar(),

                  // ── Page content ─────────────────────────────────────────
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        OnboardingStepProfile(
                          initialName: _initialName,
                          onCanProceedChanged: _onCanProceedChanged,
                        ),
                        OnboardingStepPreferences(
                          onCanProceedChanged: _onCanProceedChanged,
                        ),
                        OnboardingStepAvatar(
                          onCanProceedChanged: _onCanProceedChanged,
                        ),
                        OnboardingStepFit(
                          onCanProceedChanged: _onCanProceedChanged,
                          onFitDataChanged: _onFitDataChanged,
                        ),
                      ],
                    ),
                  ),

                  // ── Bottom button ─────────────────────────────────────────
                  _buildBottomBar(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final hasError = state.error != null;
        
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          child: Row(
            children: [
              // Logo
              const StyloLogo(size: 40),
              const Spacer(),
              // Close button (shows on error)
              if (hasError)
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () {
                    context.go('/login');
                  },
                  tooltip: 'Tutup',
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: Colors.white,
                  ),
                ),
              // Step counter
              if (!hasError)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: context.surfaceColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_step + 1} / $_totalSteps  ${_stepTitles[_step]}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: context.secondaryTextColor,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: List.generate(_totalSteps, (i) {
          final isActive = i <= _step;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < _totalSteps - 1 ? 6 : 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 4,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.accent : context.borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomBar(OnboardingState state) {
    final isLastStep = _step == _totalSteps - 1;
    final isLoading = state.isSubmitting;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        border: Border(
          top: BorderSide(color: context.dividerColor),
        ),
      ),
      child: StyloButton(
        label: isLastStep ? 'Selesai & Mulai Belanja' : 'Lanjut',
        isFullWidth: true,
        isLoading: isLoading,
        onPressed: _canProceed && !isLoading ? _onNext : null,
      ),
    );
  }
}
