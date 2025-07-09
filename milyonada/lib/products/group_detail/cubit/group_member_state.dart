  
  
import '../model/group_mmeber.dart';

abstract class GroupMemberState {}

class GroupMemberInitial extends GroupMemberState {}

class GroupMemberLoading extends GroupMemberState {}

class GroupMemberLoaded extends GroupMemberState {
  final List<GroupMember> members;

  GroupMemberLoaded(this.members);
}

class GroupMemberError extends GroupMemberState {
  final String message;

  GroupMemberError(this.message);
}
