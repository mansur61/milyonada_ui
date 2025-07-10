import '../../utils/group_status.dart';
import '../model/group.dart';
import '../model/group_mmeber.dart';

class GroupState {
  final Group? group;
  final bool isJoined;
  final bool isExpanded;
  final GroupStatus status;
  final String? errorMessage;
  final bool isLoading;

  final List<GroupMember>? members;
  final bool isMembersLoading;
  final String? membersError;

  GroupState({
    this.group,
    this.isLoading = false,
    this.isJoined = false,
    this.isExpanded = false,
    this.status = GroupStatus.initial,
    this.errorMessage,
    this.members,
    this.isMembersLoading = false,
    this.membersError,
  });

  GroupState copyWith({
    Group? group,
    bool? isJoined,
    bool? isExpanded,
    GroupStatus? status,
    String? errorMessage,
    bool? isLoading,
    List<GroupMember>? members,
    bool? isMembersLoading,
    String? membersError,
  }) {
    return GroupState(
      group: group ?? this.group,
      isJoined: isJoined ?? this.isJoined,
      isExpanded: isExpanded ?? this.isExpanded,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      members: members ?? this.members,
      isMembersLoading: isMembersLoading ?? this.isMembersLoading,
      membersError: membersError ?? this.membersError,
    );
  }
}
