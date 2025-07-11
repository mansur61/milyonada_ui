abstract class GroupCreateEvent {}

class GroupNameChanged extends GroupCreateEvent {
  final String name;
  GroupNameChanged(this.name);
}

class GroupCategoryChanged extends GroupCreateEvent {
  final String category;
  GroupCategoryChanged(this.category);
}

class GroupPrivacyChanged extends GroupCreateEvent {
  final String privacy;
  GroupPrivacyChanged(this.privacy);
}

class GroupDescriptionChanged extends GroupCreateEvent {
  final String description;
  GroupDescriptionChanged(this.description);
}

class GroupImage1Selected extends GroupCreateEvent {}

class GroupImage2Selected extends GroupCreateEvent {}

class GroupFormSubmitted extends GroupCreateEvent {}
