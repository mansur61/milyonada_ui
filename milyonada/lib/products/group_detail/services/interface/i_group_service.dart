 
import '../../model/group.dart';
import '../../model/service_result.dart';

abstract class IGroupService {
  Future<ServiceResult<bool>> joinGroup(Group group);
  Future<void> deleteGroup(String groupId);
  Future<ServiceResult<bool>> leaveGroup(Group group);
  Future<ServiceResult<List<Group>>> getGroups();
}
