 
import '../../model-aktarılacak/member.dart';

abstract class MemberState {}

class MemberInitial extends MemberState {}

class MemberLoaded extends MemberState {
  final List<Member> members;
  final Member? selectedMember;
  MemberLoaded({required this.members, this.selectedMember});
}
