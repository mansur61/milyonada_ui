import 'package:flutter_bloc/flutter_bloc.dart';

class ExpandableTextCubit extends Cubit<bool> {
  ExpandableTextCubit() : super(false);

  void expand() => emit(true);

  void collapse() => emit(false);

  void toggle() => emit(!state);
}
