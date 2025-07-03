abstract class IGroupService {
  Future<void> createGroup(String name);
  Future<void> deleteGroup(String groupId);
  Future<List<String>> getGroups();
}