 
import 'package:milyonada/features/model/group.dart';
import 'package:milyonada/features/services/interface/i_group_service.dart';

import '../model/api_list_response_model.dart';
import '../model/api_response_model.dart';
import '../model/group_mmeber.dart'; 
import '../../core/http_service.dart';


class GroupService implements IGroupService {
  final HttpService _http = HttpService();

  @override
  Future<ApiResponse<bool>> leaveGroup(Group group) {
    return _http.request<bool>(
      requestFunction: () => _http.post('/group/leave', data: group.toJson()),
      fromJson: (_) => true,  
    );
  }

  @override
  Future<ApiResponse<bool>> joinGroup(Group group) {
    return _http.request<bool>(
      requestFunction: () => _http.post('/group/join', data: group.toJson()),
      fromJson: (_) => true,
    );
  }

  @override
  Future<ApiListResponse<Group>> getGroups() {
    return _http.requestList<Group>(
      requestFunction: () => _http.get('/group'),
      fromJson: (json) => Group.fromJson(json),
    );
  }

  @override
  Future<ApiListResponse<GroupMember>> getMembersByGroupId(int groupId) {
    return _http.requestList<GroupMember>(
      requestFunction: () => _http.get('/group/members/$groupId'),
      fromJson: (json) => GroupMember.fromJson(json),
    );
  }

  @override
  Future<void> deleteGroup(String groupId) {
    throw UnimplementedError();
  }
}