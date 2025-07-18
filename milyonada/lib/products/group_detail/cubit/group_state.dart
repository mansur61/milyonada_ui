import '../../utils/group_status.dart';
import '../../../features/model/group.dart';
import '../../../features/model/group_mmeber.dart';

class GroupState {
  final Group? group;
  final bool isJoined;
  final bool isExpanded;
  final GroupStatus status;
  final String? errorMessage;
  final bool isLoading;

  final List<Group>? groups;
  final bool isGroupsLoading;

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
    this.isGroupsLoading = false,
    this.groups,
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
    bool? isGroupsLoading,
    List<GroupMember>? members,
    List<Group>? groups,
    bool? isMembersLoading,
    String? membersError,
  }) {
    return GroupState(
      group: group ?? this.group,
      isJoined: isJoined ?? this.isJoined,
      isGroupsLoading: isGroupsLoading ?? this.isGroupsLoading,
      isExpanded: isExpanded ?? this.isExpanded,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      members: members ?? this.members,
      groups: groups ?? this.groups,
      isMembersLoading: isMembersLoading ?? this.isMembersLoading,
      membersError: membersError ?? this.membersError,
    );
  }
}
