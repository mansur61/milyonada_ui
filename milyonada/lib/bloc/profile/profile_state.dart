class ProfileState {
  final bool isSubmitting;

  ProfileState({required this.isSubmitting});

  factory ProfileState.initial() => ProfileState(isSubmitting: false);

  ProfileState copyWith({bool? isSubmitting}) {
    return ProfileState(isSubmitting: isSubmitting ?? this.isSubmitting);
  }
}
