import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../ai_try_on/domain/entities/fit_profile.dart';
import '../../../ai_try_on/domain/usecases/save_fit_profile_usecase.dart';
import '../../../profile/domain/usecases/update_profile_usecase.dart';
import '../../../profile/domain/usecases/update_style_preferences_usecase.dart';
import '../../../profile/domain/usecases/upload_avatar_usecase.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final UpdateProfileUseCase updateProfileUseCase;
  final UpdateStylePreferencesUseCase updateStylePrefsUseCase;
  final SaveFitProfileUseCase saveFitProfileUseCase;
  final UploadAvatarUseCase uploadAvatarUseCase;
  final SharedPreferences prefs;

  OnboardingCubit({
    required this.updateProfileUseCase,
    required this.updateStylePrefsUseCase,
    required this.saveFitProfileUseCase,
    required this.uploadAvatarUseCase,
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
      // Validate user ID
      if (userId.isEmpty) {
        emit(state.copyWith(
          isSubmitting: false,
          error: 'Sesi tidak valid. Silakan login kembali.',
        ));
        return;
      }

      // 1. Upload avatar if provided (optional)
      if (state.avatarLocalPath != null && state.avatarLocalPath!.isNotEmpty) {
        try {
          await uploadAvatarUseCase(
            UploadAvatarParams(avatarFile: File(state.avatarLocalPath!)),
          );
        } catch (_) {
          // Avatar upload failed, but continue with onboarding
          // User can try again later in profile
        }
      }

      // 2. Update profile (name only - phone is optional and might not be supported by backend)
      final profileResult = await updateProfileUseCase(
        UpdateProfileParams(name: state.name, phone: null),
      );
      if (profileResult.isLeft) {
        final msg = profileResult.fold((f) => f.message, (_) => '');
        // If it's a validation error about preference_ids, it's a backend issue
        // Just continue with the flow
        if (msg.contains('preference_ids')) {
          // Skip this error and continue
        } else {
          emit(state.copyWith(isSubmitting: false, error: msg));
          return;
        }
      }

      // 3. Update style preferences ONLY if user selected some
      if (state.preferenceIds.isNotEmpty) {
        final prefsResult =
            await updateStylePrefsUseCase(state.preferenceIds);
        if (prefsResult.isLeft) {
          final msg = prefsResult.fold((f) => f.message, (_) => '');
          // If backend doesn't support this endpoint, continue anyway
          if (!msg.contains('preference_ids')) {
            emit(state.copyWith(isSubmitting: false, error: msg));
            return;
          }
        }
      }

      // 4. Save fit profile
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

      // 5. Mark onboarding complete for this specific user
      await prefs.setBool('${AppConstants.onboardingKey}_$userId', true);
      emit(state.copyWith(isSubmitting: false, isComplete: true));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        error: 'Terjadi kesalahan. Silakan coba lagi.',
      ));
    }
  }
}
