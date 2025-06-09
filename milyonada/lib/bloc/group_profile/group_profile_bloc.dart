import 'package:flutter_bloc/flutter_bloc.dart';
import 'group_profile_event.dart';
import 'group_profile_state.dart';
import 'package:image_picker/image_picker.dart';

class GroupProfileBloc extends Bloc<GroupProfileEvent, GroupProfileState> {
  final ImagePicker _picker = ImagePicker();

  GroupProfileBloc() : super(GroupProfileState.initial()) {
    on<GroupNameChanged>((event, emit) {
      emit(state.copyWith(groupName: event.groupName));
    });

    on<CategoryChanged>((event, emit) {
      emit(state.copyWith(category: event.category));
    });

    on<DescriptionChanged>((event, emit) {
      emit(state.copyWith(description: event.description));
    });

    on<ChangeImagePressed>((event, emit) async {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(state.copyWith(imagePath: image.path));
      }
    });

    on<SavePressed>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      await Future.delayed(Duration(seconds: 2)); // Simülasyon
      emit(state.copyWith(isSubmitting: false));
    });
  }
}
