import 'group_mmeber.dart';
import 'group_post.dart';
import 'category.dart';  // Kategori modelin

enum GroupType { PRIVATE, PUBLIC, HIDDEN }
enum MemberStatus { INVITED, JOINED, REQUESTED, NONE, BLOCKED }

class Group {
  final String groupId;
  final String name;
  final String description;
  final String imageUrl; 
  final Category category;
  final List<GroupMember> members;
  final List<GroupPost> posts;

  final GroupType? groupType;
  final MemberStatus? memberStatus;
  final int? memberCount;

  Group({
    required this.groupId,
    required this.name,
    required this.description,
    required this.imageUrl, 
    required this.category,
    required this.members,
    required this.posts,
    this.groupType,
    this.memberStatus,
    this.memberCount,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    GroupType? parseGroupType(String? value) {
      if (value == null) return null;
      switch (value.toUpperCase()) {
        case 'PRIVATE':
          return GroupType.PRIVATE;
        case 'PUBLIC':
          return GroupType.PUBLIC;
        case 'HIDDEN':
          return GroupType.HIDDEN;
        default:
          return null;
      }
    }

    MemberStatus? parseMemberStatus(String? value) {
      if (value == null) return null;
      switch (value.toUpperCase()) {
        case 'INVITED':
          return MemberStatus.INVITED;
        case 'JOINED':
          return MemberStatus.JOINED;
        case 'REQUESTED':
          return MemberStatus.REQUESTED;
        case 'NONE':
          return MemberStatus.NONE;
        case 'BLOCKED':
          return MemberStatus.BLOCKED;
        default:
          return null;
      }
    }

    return Group(
      groupId: json['groupId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String, 
      category: Category.fromMap(json['category']),
      members: (json['members'] as List<dynamic>)
          .map((e) => GroupMember.fromjSON(e))
          .toList(),
      posts: (json['posts'] as List<dynamic>)
          .map((e) => GroupPost.fromjSON(e))
          .toList(),
      groupType: parseGroupType(json['groupType']),
      memberStatus: parseMemberStatus(json['memberStatus']),
      memberCount: json['memberCount'] != null
          ? int.tryParse(json['memberCount'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'groupId': groupId,
        'name': name,
        'description': description,
        'imageUrl': imageUrl, 
        'category': category.toMap(),
        'members': members.map((e) => e.toMap()).toList(),
        'posts': posts.map((e) => e.toMap()).toList(),
        'groupType': groupType?.name,
        'memberStatus': memberStatus?.name,
        'memberCount': memberCount,
      };
}
