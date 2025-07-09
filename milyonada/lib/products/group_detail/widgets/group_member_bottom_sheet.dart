import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/group_member_cubit.dart';
import '../cubit/group_member_state.dart'; 

class GroupMemberBottomSheet extends StatelessWidget {
  const GroupMemberBottomSheet({super.key, required List members});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupMemberCubit, GroupMemberState>(
      builder: (context, state) {
        if (state is GroupMemberLoading) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is GroupMemberLoaded) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.members.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final member = state.members[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(member.company.profileImage),
                ),
                title: Text(member.company.name),
                subtitle: Text(member.memberRole),
              );
            },
          );
        } else if (state is GroupMemberError) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(child: Text('Hata: ${state.message}')),
          );
        }

        return const SizedBox(); // initial durum
      },
    );
  }
}
