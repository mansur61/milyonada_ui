part of 'group_bloc.dart';

abstract class GroupState extends Equatable {
  @override
  List<Object> get props => [];
}

class GroupInitial extends GroupState {}

class GroupLoaded extends GroupState {
  final List<GroupModel> groups;

  GroupLoaded({required this.groups});

  @override
  List<Object> get props => [groups];
}
