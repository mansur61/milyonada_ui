class GroupCreateState {
  final String name;
  final String? category;
  final String privacy;
  final String description;
  final String? image1Path;
  final String? image2Path;
  final bool isSubmitting;

  GroupCreateState({
    this.name = '',
    this.category,
    this.privacy = 'Açık',
    this.description = '',
    this.image1Path,
    this.image2Path,
    this.isSubmitting = false,
  });

  GroupCreateState copyWith({
    String? name,
    String? category,
    String? privacy,
    String? description,
    String? image1Path,
    String? image2Path,
    bool? isSubmitting,
  }) {
    return GroupCreateState(
      name: name ?? this.name,
      category: category ?? this.category,
      privacy: privacy ?? this.privacy,
      description: description ?? this.description,
      image1Path: image1Path ?? this.image1Path,
      image2Path: image2Path ?? this.image2Path,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
