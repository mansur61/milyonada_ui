class GroupShareState {
  final String text;

  GroupShareState({this.text = ''});

  GroupShareState copyWith({String? text}) {
    return GroupShareState(text: text ?? this.text);
  }
}
