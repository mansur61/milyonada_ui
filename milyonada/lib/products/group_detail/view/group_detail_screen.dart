import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/group_cubit.dart';
import '../cubit/group_state.dart';
import '../widgets/group_member_bottom_sheet.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupCubit()..loadGroup(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Grup Detay'),
          leading: const BackButton(),
        ),
        body: BlocBuilder<GroupCubit, GroupState>(
          builder: (context, state) {
            switch (state.status) {
              case GroupStatus.loading:
                return const Center(child: CircularProgressIndicator());

              case GroupStatus.failure:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.errorMessage ?? 'Bilinmeyen bir hata oluştu.',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<GroupCubit>().loadGroup(),
                          child: const Text('Tekrar Dene'),
                        ),
                      ],
                    ),
                  ),
                );

              case GroupStatus.success:
                final group = state.group!;
                final moderators = group.members
                    .where((m) => m.role.toLowerCase() == 'admin')
                    .toList();

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Grup Ana Görsel
                      if (group.imageUrl.isNotEmpty)
                        SizedBox(
                          height: 120, // Görsel yüksekliği
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  group.imageUrl,
                                  height: 160,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 8),
                          ),
                        ),

                      const SizedBox(height: 12),

                      // Grup Başlık ve Açıklama
                      Text(
                        group.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 8),
                      Text(
                        group.category.description,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 16),

                      const SizedBox(height: 8),
                      Text(group.description),
                      const SizedBox(height: 16),

                      // Üye Sayısı ve Üyeleri Gör Butonu
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${group.members.length} üye'),
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                builder: (context) => GroupMemberBottomSheet(
                                    members: group.members),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                            child: const Text('Üyeleri Gör'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Katıl / Ayrıl Butonu
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () => context.read<GroupCubit>().toggleJoin(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(state.isJoined ? 'Ayrıl' : 'Katıl'),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Moderatörler
                      if (moderators.isNotEmpty) ...[
                        const Text(
                          'Moderatörler',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 60, // Avatar yüksekliğine göre ayarlanır
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: moderators.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final mod = moderators[index];
                              return CircleAvatar(
                                radius: 24,
                                backgroundImage:
                                    NetworkImage(mod.profileImageUrl),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                );

              case GroupStatus.initial:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
