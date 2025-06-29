import '../model/group.dart';

enum GroupStatus { initial, loading, success, failure }

class GroupState {
  final Group? group;
  final bool isJoined;
  final GroupStatus status;
  final String? errorMessage;
  final bool isLoading; 

  GroupState({
    this.group,
    this.isLoading = false,
    this.isJoined = false,
    this.status = GroupStatus.initial,
    this.errorMessage,
  });

  GroupState copyWith({
    Group? group,
    bool? isJoined,
    GroupStatus? status,
    String? errorMessage,
    bool? isLoading,
  }) {
    return GroupState(
      group: group ?? this.group,
      isJoined: isJoined ?? this.isJoined,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
