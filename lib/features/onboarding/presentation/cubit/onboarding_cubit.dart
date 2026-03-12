import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../ai_try_on/domain/entities/fit_profile.dart';
import '../../../ai_try_on/domain/usecases/save_fit_profile_usecase.dart';
import '../../../profile/domain/usecases/update_profile_usecase.dart';
import '../../../profile/domain/usecases/update_style_preferences_usecase.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final UpdateProfileUseCase updateProfileUseCase;
  final UpdateStylePreferencesUseCase updateStylePrefsUseCase;
  final SaveFitProfileUseCase saveFitProfileUseCase;
  final SharedPreferences prefs;

  OnboardingCubit({
    required this.updateProfileUseCase,
    required this.updateStylePrefsUseCase,
    required this.saveFitProfileUseCase,
    required this.prefs,
  }) : super(const OnboardingState());

  void setProfileData(String name, String? phone) {
    emit(state.copyWith(
      name: name,
      phone: phone?.trim().isEmpty == true ? null : phone?.trim(),
    ));
  }

  void setPreferences(List<String> ids) {
    emit(state.copyWith(preferenceIds: ids));
  }

  void setAvatar(String? path) {
    emit(state.copyWith(avatarLocalPath: path));
  }

  Future<void> submitOnboarding({
    required String userId,
    required double height,
    required double weight,
    required double chest,
    required double waist,
    required double hips,
    required String preferredSize,
  }) async {
    emit(state.copyWith(isSubmitting: true, error: null));

    try {
      // 1. Update profile (name + phone)
      final profileResult = await updateProfileUseCase(
        UpdateProfileParams(name: state.name, phone: state.phone),
      );
      if (profileResult.isLeft) {
        final msg = profileResult.fold((f) => f.message, (_) => '');
        emit(state.copyWith(isSubmitting: false, error: msg));
        return;
      }

      // 2. Update style preferences (skip if none selected)
      if (state.preferenceIds.isNotEmpty) {
        final prefsResult =
            await updateStylePrefsUseCase(state.preferenceIds);
        if (prefsResult.isLeft) {
          final msg = prefsResult.fold((f) => f.message, (_) => '');
          emit(state.copyWith(isSubmitting: false, error: msg));
          return;
        }
      }

      // 3. Save fit profile
      final fitResult = await saveFitProfileUseCase(
        SaveFitProfileParams(
          profile: FitProfile(
            height: height,
            weight: weight,
            chest: chest,
            waist: waist,
            hips: hips,
            preferredSize: preferredSize,
          ),
        ),
      );
      if (fitResult.isLeft) {
        final msg = fitResult.fold((f) => f.message, (_) => '');
        emit(state.copyWith(isSubmitting: false, error: msg));
        return;
      }

      // 4. Mark onboarding complete for this specific user
      await prefs.setBool('${AppConstants.onboardingKey}_$userId', true);
      emit(state.copyWith(isSubmitting: false, isComplete: true));
    } catch (_) {
      emit(state.copyWith(
        isSubmitting: false,
        error: 'Terjadi kesalahan. Silakan coba lagi.',
      ));
    }
  }
}
