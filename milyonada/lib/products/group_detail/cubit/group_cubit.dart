import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/group.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit() : super(GroupState());

  Future<Group> loadGroupFromAssets() async {
    final jsonString = await rootBundle.loadString('assets/group_test.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    final Map<String, dynamic> firstGroupMap = jsonList.first;
    return Group.fromJson(firstGroupMap);
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
      final group = await loadGroupFromAssets();
      debugPrint("success");
      emit(state.copyWith(
        group: group,
        isJoined: group.memberStatus == MemberStatus.JOINED ? true  : false,
        status: GroupStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: GroupStatus.failure));
    }
  }

  Future<void> toggleJoin() async {
    if (state.isLoading) return; // işlemi tekrar başlatma

    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 2)); // api isteği simülasyonu

    emit(state.copyWith(
      isJoined: !state.isJoined,
      isLoading: false,
    ));
  }
}
