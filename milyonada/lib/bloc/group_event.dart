part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadGroups extends GroupEvent {}
