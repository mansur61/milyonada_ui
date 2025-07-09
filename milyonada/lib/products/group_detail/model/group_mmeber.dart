import '../../utils/member_status.dart';
import 'company.dart';
 

class GroupMember {
  final Company company;
  final DateTime? applicationDate;
  final DateTime? approvalDate;
  final DateTime? rejectionDate;
  final MemberStatus? status;
  final String memberRole;
  final String? applicationMessage;

  GroupMember({
    required this.company,
    this.applicationDate,
    this.approvalDate,
    this.rejectionDate,
    this.status,
    required this.memberRole,
    this.applicationMessage,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    MemberStatus? parseStatus(String? value) {
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

    DateTime? parseDate(dynamic timestamp) {
      if (timestamp == null) return null;
      if (timestamp is int) {
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      }
      return null;
    }

    return GroupMember(
      company: Company.fromJson(json['company']),
      applicationDate: parseDate(json['applicationDate']),
      approvalDate: parseDate(json['approvalDate']),
      rejectionDate: parseDate(json['rejectionDate']),
      status: parseStatus(json['status']),
      memberRole: json['role'] ?? '',
      applicationMessage: json['applicationMessage'],
    );
  }

  Map<String, dynamic> toJson() => {
        'company': company.toJson(),
        'applicationDate': applicationDate?.millisecondsSinceEpoch,
        'approvalDate': approvalDate?.millisecondsSinceEpoch,
        'rejectionDate': rejectionDate?.millisecondsSinceEpoch,
        'status': status?.name,
        'role': memberRole,
        'applicationMessage': applicationMessage,
      };

  GroupMember copyWith({
    Company? company,
    DateTime? applicationDate,
    DateTime? approvalDate,
    DateTime? rejectionDate,
    MemberStatus? status,
    String? memberRole,
    String? applicationMessage,
  }) {
    return GroupMember(
      company: company ?? this.company,
      applicationDate: applicationDate ?? this.applicationDate,
      approvalDate: approvalDate ?? this.approvalDate,
      rejectionDate: rejectionDate ?? this.rejectionDate,
      status: status ?? this.status,
      memberRole: memberRole ?? this.memberRole,
      applicationMessage: applicationMessage ?? this.applicationMessage,
    );
  }
}
