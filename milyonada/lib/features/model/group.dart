import '../../products/utils/group_type.dart';
import '../../products/utils/member_status.dart';
import 'category.dart';  
import 'mederator.dart'; 


class Group {
  final int? id;
  final String name;
  final String description;
  final String imageUrl;
  final String? coverUrl;
  final Category category;
  final List<GroupMederator> admins;
  final GroupType? groupType;
  final MemberStatus? memberStatus;
  final int? memberCount;

  Group({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.coverUrl,
    required this.category,
    required this.admins,
    this.groupType,
    this.memberStatus,
    this.memberCount,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    GroupType? parseGroupType(String? value) {
      switch (value?.toUpperCase()) {
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
      switch (value?.toUpperCase()) {
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
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      coverUrl: json['coverUrl'],
      category: Category.fromMap(json['category']),
      admins: (json['admins'] as List<dynamic>)
          .map((e) => GroupMederator.fromJson(e))
          .toList(),
      groupType: parseGroupType(json['groupType']),
      memberStatus: parseMemberStatus(json['memberStatus']),
      memberCount: json['memberCount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'coverUrl': coverUrl,
        'category': category.toMap(),
        'admins': admins.map((e) => e.toJson()).toList(),
        'groupType': groupType?.name,
        'memberStatus': memberStatus?.name,
        'memberCount': memberCount,
      };


 Group copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    String? coverUrl,
    Category? category,
    List<GroupMederator>? members,
    GroupType? groupType,
    MemberStatus? memberStatus,
    int? memberCount,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      category: category ?? this.category,
      admins: members ?? this.admins,
      groupType: groupType ?? this.groupType,
      memberStatus: memberStatus ?? this.memberStatus,
      memberCount: memberCount ?? this.memberCount,
    );
  }
}


