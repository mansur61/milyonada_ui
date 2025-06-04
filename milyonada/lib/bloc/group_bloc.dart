import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/group_model.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitial()) {
    on<LoadGroups>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(GroupLoaded(groups: [
        GroupModel(
          name: 'Fotoğrafçılık Kulübü',
          description: 'Fotoğraf tutkunları için bir topluluk',
          members: 1254,
          imageUrl: 'https://picsum.photos/150?random=2', // Fotoğrafçılık
          buttonText: 'Katıl',
        ),
        GroupModel(
          name: 'Kitap Kulübü',
          description: 'Romanlar ve daha fazlası üzerine tartışmalar',
          members: 834,
          imageUrl: 'https://picsum.photos/150?random=1', // Kitap Kulübü
          buttonText: 'Katıl',
        ),
        GroupModel(
          name: 'Yazılım Mühendisleri',
          description: 'Yazılım geliştirme profesyonelleri grubu',
          members: 2310,
          imageUrl: 'https://picsum.photos/150?random=3', // Yazılım
          buttonText: 'Başvur',
        ),
      ]));
    });
  }
}
