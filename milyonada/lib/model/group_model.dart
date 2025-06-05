// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  });
 

  Map<String, dynamic> toMap() 
    => <String, dynamic>{
      'name': name,
      'description': description,
      'members': members,
      'imageUrl': imageUrl,
      'buttonText': buttonText,
      'category': category,
      'privacy': privacy,
      'image1Path': image1Path,
      'image2Path': image2Path,
    };
  

  factory GroupModel.fromMap(Map<String, dynamic> map) 
    => GroupModel(
      name: map['name'] as String,
      description: map['description'] as String,
      members: map['members'] as int,
      imageUrl: map['imageUrl'] as String,
      buttonText: map['buttonText'] as String,
      category: map['category'] as String,
      privacy: map['privacy'] as String,
      image1Path: map['image1Path'] != null ? map['image1Path'] as String : null,
      image2Path: map['image2Path'] != null ? map['image2Path'] as String : null,
    );
  
}
