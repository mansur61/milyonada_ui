class GroupState {
  final int selectedTab;
  GroupState({required this.selectedTab});

  GroupState copyWith({int? selectedTab}) {
    return GroupState(selectedTab: selectedTab ?? this.selectedTab);
  }
}
