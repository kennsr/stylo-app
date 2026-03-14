import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/get_style_preferences_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/update_style_preferences_usecase.dart';
import '../../domain/usecases/upload_avatar_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetStylePreferencesUseCase getStylePreferencesUseCase;
  final UpdateStylePreferencesUseCase updateStylePreferencesUseCase;
  final UploadAvatarUseCase uploadAvatarUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.getStylePreferencesUseCase,
    required this.updateStylePreferencesUseCase,
    required this.uploadAvatarUseCase,
  }) : super( ProfileInitial()) {
    on<ProfileFetch>(_onFetch);
    on<ProfileUpdate>(_onUpdate);
    on<ProfileUpdatePreferences>(_onUpdatePreferences);
    on<ProfileUploadAvatar>(_onUploadAvatar);
  }

  Future<void> _onFetch(ProfileFetch event, Emitter<ProfileState> emit) async {
    emit( ProfileLoading());

    final profileResult = await getProfileUseCase( NoParams());
    if (profileResult.isLeft) {
      profileResult.fold(
        (failure) => emit(ProfileError(message: failure.message)),
        (_) {},
      );
      return;
    }

    final user = profileResult.fold((l) => throw Exception(), (r) => r);

    final prefsResult = await getStylePreferencesUseCase( NoParams());
    prefsResult.fold(
      (failure) => emit(ProfileLoaded(user: user, stylePreferences: [])),
      (prefs) => emit(ProfileLoaded(user: user, stylePreferences: prefs)),
    );
  }

  Future<void> _onUpdate(
      ProfileUpdate event, Emitter<ProfileState> emit) async {
    final currentState = state;
    emit( ProfileUpdating());

    final result = await updateProfileUseCase(
      UpdateProfileParams(name: event.name, phone: event.phone),
    );

    result.fold(
      (failure) => emit(ProfileError(message: failure.message)),
      (user) {
        final prefs = currentState is ProfileLoaded
            ? currentState.stylePreferences
            : <dynamic>[];
        emit(ProfileLoaded(
          user: user,
          stylePreferences: List.from(prefs),
        ));
      },
    );
  }

  Future<void> _onUpdatePreferences(
      ProfileUpdatePreferences event, Emitter<ProfileState> emit) async {
    final currentState = state;
    if (currentState is! ProfileLoaded) return;

    emit( ProfileUpdating());

    final result =
        await updateStylePreferencesUseCase(event.preferenceIds);

    result.fold(
      (failure) => emit(ProfileError(message: failure.message)),
      (_) {
        final updatedPrefs = currentState.stylePreferences.map((pref) {
          return pref.copyWith(
            isSelected: event.preferenceIds.contains(pref.id),
          );
        }).toList();

        emit(ProfileLoaded(
          user: currentState.user,
          stylePreferences: updatedPrefs,
        ));
      },
    );
  }

  Future<void> _onUploadAvatar(
      ProfileUploadAvatar event, Emitter<ProfileState> emit) async {
    final currentState = state;
    emit( ProfileUpdating());

    final result = await uploadAvatarUseCase(
      UploadAvatarParams(avatarFile: event.avatarFile),
    );

    result.fold(
      (failure) => emit(ProfileError(message: failure.message)),
      (user) {
        final prefs = currentState is ProfileLoaded
            ? currentState.stylePreferences
            : <dynamic>[];
        emit(ProfileLoaded(
          user: user,
          stylePreferences: List.from(prefs),
        ));
      },
    );
  }
}
