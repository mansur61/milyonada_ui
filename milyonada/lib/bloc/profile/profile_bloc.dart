import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<ChangeImagePressed>((event, emit) {
      // TODO: Fotoğraf değiştirme işlemi
    });

    on<SubmitProfilePressed>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      await Future.delayed(Duration(seconds: 2)); // Örnek işlem
      emit(state.copyWith(isSubmitting: false));
    });
  }
}
