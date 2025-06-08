import '../../model/member.dart';

abstract class MemberEvent {}

class LoadMembers extends MemberEvent {}

class ShowMemberOptions extends MemberEvent {
  final Member member;
  ShowMemberOptions(this.member);
}
