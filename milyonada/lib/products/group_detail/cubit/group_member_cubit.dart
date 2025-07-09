import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../services/group_service.dart';
import 'group_member_state.dart'; 

class GroupMemberCubit extends Cubit<GroupMemberState> {
  final GroupService service;

  GroupMemberCubit(this.service) : super(GroupMemberInitial());

  Future<void> fetchMembers(int groupId) async {
    emit(GroupMemberLoading());

    final result = await service.getMembersByGroupId(groupId);

    if (result.success && result.data != null) {
      emit(GroupMemberLoaded(result.data!));
    } else {
      emit(GroupMemberError(result.message ?? 'Bilinmeyen bir hata oluştu.'));
    }
  }
}
