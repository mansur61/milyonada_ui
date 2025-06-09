abstract class GroupProfileEvent {}

class GroupNameChanged extends GroupProfileEvent {
  final String groupName;
  GroupNameChanged(this.groupName);
}

class CategoryChanged extends GroupProfileEvent {
  final String category;
  CategoryChanged(this.category);
}

class DescriptionChanged extends GroupProfileEvent {
  final String description;
  DescriptionChanged(this.description);
}

class ChangeImagePressed extends GroupProfileEvent {}

class SavePressed extends GroupProfileEvent {}
