 
import '../../model/api_list_response_model.dart' show ApiListResponse;
import '../../model/api_response_model.dart';
import '../../model/group.dart';
import '../../model/group_mmeber.dart';  

abstract class IGroupService {
  Future<ApiResponse<bool>> joinGroup(Group group);
  Future<void> deleteGroup(String groupId);
  Future<ApiResponse<bool>> leaveGroup(Group group);
  Future<ApiListResponse<Group>> getGroups();
  Future<ApiListResponse<GroupMember>> getMembersByGroupId(int groupId);
}
