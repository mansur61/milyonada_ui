class GroupProfileState {
  final String groupName;
  final String category;
  final String description;
  final String? imagePath;
  final bool isSubmitting;

  GroupProfileState({
    required this.groupName,
    required this.category,
    required this.description,
    this.imagePath,
    this.isSubmitting = false,
  });

  GroupProfileState copyWith({
    String? groupName,
    String? category,
    String? description,
    String? imagePath,
    bool? isSubmitting,
  }) {
    return GroupProfileState(
      groupName: groupName ?? this.groupName,
      category: category ?? this.category,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  factory GroupProfileState.initial() {
    return GroupProfileState(
      groupName: '',
      category: '',
      description: '',
      imagePath: null,
    );
  }
}
