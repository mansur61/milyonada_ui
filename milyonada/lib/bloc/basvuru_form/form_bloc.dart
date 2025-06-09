import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_event.dart';
import 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<PurposeChanged>((event, emit) {
      emit(state.copyWith(purpose: event.purpose));
    });

    on<NoteChanged>((event, emit) {
      emit(state.copyWith(note: event.note));
    });

    on<SubmitForm>((event, emit) {
      // Simulate submission
      emit(state.copyWith(isSubmitted: true));
    });
  }
}
