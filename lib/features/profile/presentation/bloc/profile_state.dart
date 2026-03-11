import 'package:equatable/equatable.dart';
import '../../../../features/auth/domain/entities/user.dart';
import '../../domain/entities/style_preference.dart';

abstract class ProfileState extends Equatable {
   const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
   const ProfileInitial();
}

class ProfileLoading extends ProfileState {
   const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final User user;
  final List<StylePreference> stylePreferences;

   const ProfileLoaded({
    required this.user,
    required this.stylePreferences,
  });

  @override
  List<Object?> get props => [user, stylePreferences];
}

class ProfileUpdating extends ProfileState {
   const ProfileUpdating();
}

class ProfileError extends ProfileState {
  final String message;
   const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
