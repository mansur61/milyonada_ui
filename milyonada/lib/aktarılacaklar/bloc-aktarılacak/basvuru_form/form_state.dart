class FormState {
  final String name;
  final String purpose;
  final String note;
  final bool isSubmitted;

  FormState({
    this.name = '',
    this.purpose = '',
    this.note = '',
    this.isSubmitted = false,
  });

  FormState copyWith({
    String? name,
    String? purpose,
    String? note,
    bool? isSubmitted,
  }) {
    return FormState(
      name: name ?? this.name,
      purpose: purpose ?? this.purpose,
      note: note ?? this.note,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}
