import 'dart:convert';

class GroupModel {
  final String name;
  final String description;
  final int members;
  final String imageUrl;
  final String buttonText;
  final String category;
  final String privacy;
  final String? image1Path;
  final String? image2Path;
  final String title;
  final String subtitle;
  final int memberCount;
  final List<String> moderators;
  final List<String>? images;

  GroupModel({
    required this.name,
    required this.description,
    required this.members,
    required this.imageUrl,
    required this.buttonText,
    required this.category,
    required this.privacy,
    this.image1Path,
    this.image2Path,
    required this.title,
    required this.subtitle,
    required this.memberCount,
    required this.moderators,
    this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'members': members,
      'imageUrl': imageUrl,
      'buttonText': buttonText,
      'category': category,
      'privacy': privacy,
      'image1Path': image1Path,
      'image2Path': image2Path,
      'title': title,
      'subtitle': subtitle,
      'memberCount': memberCount,
      'moderators': moderators,
      'images': images,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      members: map['members'] ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      buttonText: map['buttonText'] ?? '',
      category: map['category'] ?? '',
      privacy: map['privacy'] ?? '',
      image1Path: map['image1Path'],
      image2Path: map['image2Path'],
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      memberCount: map['memberCount'] ?? 0,
      moderators: List<String>.from(map['moderators'] ?? []),
      images: map['images'] != null ? List<String>.from(map['images']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) => GroupModel.fromMap(json.decode(source));
}
