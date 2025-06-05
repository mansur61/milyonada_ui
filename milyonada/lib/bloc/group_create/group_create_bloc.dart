import 'package:flutter_bloc/flutter_bloc.dart';
import 'group_create_event.dart';
import 'group_create_state.dart';

class GroupCreateBloc extends Bloc<GroupCreateEvent, GroupCreateState> {
  GroupCreateBloc() : super(GroupCreateState()) {
    on<GroupNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<GroupCategoryChanged>((event, emit) {
      emit(state.copyWith(category: event.category));
    });

    on<GroupPrivacyChanged>((event, emit) {
      emit(state.copyWith(privacy: event.privacy));
    });

    on<GroupDescriptionChanged>((event, emit) {
      emit(state.copyWith(description: event.description));
    });

    on<GroupImage1Selected>((event, emit) {
      // Simülasyon: gerçek görsel yükleme yerine dummy path
      emit(state.copyWith(image1Path: 'path/to/image1.jpg'));
    });

    on<GroupImage2Selected>((event, emit) {
      emit(state.copyWith(image2Path: 'path/to/image2.jpg'));
    });

    on<GroupFormSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isSubmitting: false));
    });
  }
}
