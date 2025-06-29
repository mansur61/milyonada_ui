import 'package:flutter/material.dart';
import '../model/group_mmeber.dart'; // GroupMember modelini doğru import ettiğinden emin ol

class GroupMemberBottomSheet extends StatelessWidget {
  final List<GroupMember> members;

  const GroupMemberBottomSheet({Key? key, required this.members})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (_, controller) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Grup Üyeleri',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                controller: controller,
                itemCount: members.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (_, index) {
                  final member = members[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(member.profileImageUrl),
                    ),
                    title: Text(member.name),
                    subtitle: Text(member.email),
                    trailing: Text(
                      member.role,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
