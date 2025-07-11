import 'package:flutter/material.dart';

import '../../model/group_mmeber.dart'; 

class GroupMemberBottomSheet extends StatelessWidget {
  final List<GroupMember>? members;
  final bool isLoading;
  final String? error;

  const GroupMemberBottomSheet({
    super.key,
    required this.members,
    required this.isLoading,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Center(child: Text('Hata: $error')),
      );
    }

    if (members == null || members!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: Text('Üye bulunamadı')),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: members!.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final member = members![index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(member.company.profileImage),
          ),
          title: Text(member.company.name),
          subtitle: Text(member.memberRole),
        );
      },
    );
  }
}
