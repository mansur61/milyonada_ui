abstract class GroupEvent {}

class TabChanged extends GroupEvent {
  final int index;
  TabChanged(this.index);
}
