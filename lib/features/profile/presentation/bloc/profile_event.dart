import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
   const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileFetch extends ProfileEvent {
   const ProfileFetch();
}

class ProfileUpdate extends ProfileEvent {
  final String name;
  final String? phone;

   const ProfileUpdate({required this.name, this.phone});

  @override
  List<Object?> get props => [name, phone];
}

class ProfileUpdatePreferences extends ProfileEvent {
  final List<String> preferenceIds;

   const ProfileUpdatePreferences({required this.preferenceIds});

  @override
  List<Object?> get props => [preferenceIds];
}
