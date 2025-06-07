import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/group_model.dart'; 

class GroupState {
  final GroupModel? group;
  final bool isJoined;
  GroupState({this.group, this.isJoined = false});
}

class GroupCubit extends Cubit<GroupState> {
  GroupCubit() : super(GroupState());

  void loadGroup() {
    final group = GroupModel(
      title: 'Pazarlama Profesyonelleri',
      subtitle: 'Ağ oluşturma',
      description:
          'Pazarlama profesyonelleri için bir topluluk. Daha fazla bilgi burada görüntülenir.',
      memberCount: 1450,
      moderators: [
        'https://picsum.photos/150?random=2',
        'https://picsum.photos/150?random=1'
      ],
      images: [
        'https://picsum.photos/150?random=1',
        'https://picsum.photos/150?random=2'
      ], name: '', members: 0, imageUrl: '', buttonText: '', category: '', privacy: '',
    );
    emit(GroupState(group: group));
  }

  void toggleJoin() {
    emit(GroupState(group: state.group, isJoined: !state.isJoined));
  }
}