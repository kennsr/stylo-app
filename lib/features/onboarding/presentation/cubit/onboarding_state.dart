class OnboardingState {
  final String name;
  final String? phone;
  final List<String> preferenceIds;
  final String? avatarLocalPath;
  final bool isSubmitting;
  final bool isComplete;
  final String? error;

  const OnboardingState({
    this.name = '',
    this.phone,
    this.preferenceIds = const [],
    this.avatarLocalPath,
    this.isSubmitting = false,
    this.isComplete = false,
    this.error,
  });

  // Sentinel for nullable copyWith fields
  static const _unset = Object();

  OnboardingState copyWith({
    String? name,
    Object? phone = _unset,
    List<String>? preferenceIds,
    Object? avatarLocalPath = _unset,
    bool? isSubmitting,
    bool? isComplete,
    Object? error = _unset,
  }) {
    return OnboardingState(
      name: name ?? this.name,
      phone: identical(phone, _unset) ? this.phone : phone as String?,
      preferenceIds: preferenceIds ?? this.preferenceIds,
      avatarLocalPath: identical(avatarLocalPath, _unset)
          ? this.avatarLocalPath
          : avatarLocalPath as String?,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isComplete: isComplete ?? this.isComplete,
      error: identical(error, _unset) ? this.error : error as String?,
    );
  }
}
