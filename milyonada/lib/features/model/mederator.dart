import 'company.dart';

class GroupMederator {
  final Company company;
  final String memberRole;

  GroupMederator({
    required this.company,
    required this.memberRole,
  });

  factory GroupMederator.fromJson(Map<String, dynamic> json) {
    return GroupMederator(
      company: Company.fromJson(json['company']),
      memberRole: json['memberRole'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'company': company.toJson(),
        'memberRole': memberRole,
      };

  GroupMederator copyWith({
    Company? company,
    String? memberRole,
  }) {
    return GroupMederator(
      company: company ?? this.company,
      memberRole: memberRole ?? this.memberRole,
    );
  }
} 