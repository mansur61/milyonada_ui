import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/member.dart'; 
import 'member_management_event.dart';
import 'member_management_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberBloc() : super(MemberInitial()) {
    on<LoadMembers>((event, emit) {
      emit(MemberLoaded(members: [
        Member(name: "Ali Yılmaz", initials: "A"),
        Member(name: "Ayşe Demir", initials: "A"),
        Member(name: "Mehmet Kaya", initials: "M"),
      ]));
    });

    on<ShowMemberOptions>((event, emit) {
      if (state is MemberLoaded) {
        final currentState = state as MemberLoaded;
        emit(MemberLoaded(
          members: currentState.members,
          selectedMember: event.member,
        ));
      }
    });
  }
}
