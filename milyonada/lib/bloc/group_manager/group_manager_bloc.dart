import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_manager_event.dart';
import 'group_manager_state.dart'; 

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupState(selectedTab: 0)) {
    on<TabChanged>((event, emit) {
      emit(state.copyWith(selectedTab: event.index));
    });
  }
}
