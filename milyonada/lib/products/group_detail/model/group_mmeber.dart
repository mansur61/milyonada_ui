// ignore_for_file: public_member_api_docs, sort_constructors_first
 
class GroupMember {
  final String memberId;
  final String name;
  final String email;
  final String profileImageUrl;
  final String role;

  GroupMember({
    required this.memberId,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.role,
  });

  GroupMember copyWith({
    String? memberId,
    String? name,
    String? email,
    String? profileImageUrl,
    String? role,
  }) {
    return GroupMember(
      memberId: memberId ?? this.memberId,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() =>
     <String, dynamic>{
      'memberId': memberId,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'role': role,
    };
  

  factory GroupMember.fromjSON(Map<String, dynamic> map) 
    => GroupMember(
      memberId: map['memberId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profileImageUrl: map['profileImageUrl'] as String,
      role: map['role'] as String,
    );
  
 
}
