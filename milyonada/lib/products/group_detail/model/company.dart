class Company {
  final int id;
  final String name;
  final String description;
  final String profileImage;

  Company({
    required this.id,
    required this.name,
    required this.description,
    required this.profileImage,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      profileImage: json['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'profileImage': profileImage,
      };

  Company copyWith({
    int? id,
    String? name,
    String? description,
    String? profileImage,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
