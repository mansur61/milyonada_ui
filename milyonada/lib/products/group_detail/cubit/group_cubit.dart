import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/member_status.dart';
import '../model/group.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../services/group_service.dart';
import 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final grpService = GroupService();
  GroupCubit() : super(GroupState());

  Future<Group> loadGroupFromAssets() async {
    final jsonString = await rootBundle.loadString('assets/group_test.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    final Map<String, dynamic> firstGroupMap = jsonList.first;
    return Group.fromJson(firstGroupMap);
  }

  Future<List<Group>> loadGroups() async {
    final groupList = await grpService.getGroups();
    return groupList.data ?? [];
  }

  Future<List<Group>> loadGroupsFromAssets() async {
    final jsonString = await rootBundle.loadString('assets/group_test.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((e) => Group.fromJson(e)).toList();
  }

  Future<void> loadGroup() async {
    debugPrint("loading");
    emit(state.copyWith(status: GroupStatus.loading));
    try {
      //final group = await loadGroupFromAssets();
      var list = await loadGroups();
      debugPrint("success");
      emit(state.copyWith(
        group: list.first,
        isJoined: list.first.memberStatus == MemberStatus.JOINED ? true : false,
        status: GroupStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: GroupStatus.failure));
    }
  }

  Future<void> toggleJoin() async {
    if (state.isLoading || state.group == null) return;

    emit(state.copyWith(isLoading: true));

    final result = state.isJoined
        ? await Future.delayed(const Duration(seconds: 2)) //grpService.leaveGroup(state.group!)
        : await grpService.joinGroup(state.group!);

    if (result.success && result.data == true) {
      emit(state.copyWith(
        isJoined: !state.isJoined,
        isLoading: false,
      ));
    } else {
      debugPrint("Join/Leave failed: ${result.message}");
      emit(state.copyWith(isLoading: false));
    }
  }
}
