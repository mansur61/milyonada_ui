import 'package:flutter_bloc/flutter_bloc.dart';
import 'group_share_event.dart';
import 'group_share_state.dart';

class GroupShareBloc extends Bloc<GroupShareEvent, GroupShareState> {
  GroupShareBloc() : super(GroupShareState()) {
    on<TextChanged>((event, emit) {
      emit(state.copyWith(text: event.text));
    });

    on<SubmitShare>((event, emit) {
      // Paylaşım yapılır
      print("Paylaşılan içerik: ${state.text}");
    });

    on<OpenGallery>((event, emit) {
      print("Galeri açıldı");
    });

    on<OpenCamera>((event, emit) {
      print("Kamera açıldı");
    });

    on<AddLink>((event, emit) {
      print("Bağlantı eklendi");
    });
  }
}
