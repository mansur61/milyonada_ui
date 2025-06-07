import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/grup_detay/group_cubit.dart';

class GroupDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupCubit()..loadGroup(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Grup Detay'),
          leading: BackButton(),
        ),
        body: BlocBuilder<GroupCubit, GroupState>(
          builder: (context, state) {
            final group = state.group;

            if (group == null) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Grup Görselleri
                  if (group.images != null && group.images!.isNotEmpty)
                    Row(
                      children: group.images!.map((image) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                image,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 12),

                  /// Grup Başlık ve Açıklama
                  Text(
                    group.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    group.subtitle,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 12),
                  Text(group.description),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Devamını gör aksiyonu
                        },
                        child: const Text('Devamını gör',style: TextStyle(color: Colors.blue),),
                      ),
                    ],
                  ),

                  /// Üye Bilgileri
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${group.memberCount} üye"),
                      TextButton(
  onPressed: () {
    // Üyeleri gör
  },
  style: TextButton.styleFrom(
    backgroundColor: Colors.blue,            // Arka plan rengi
    foregroundColor: Colors.white,           // Yazı rengi
    padding: const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    ),
    textStyle: const TextStyle(fontSize: 14),
  ),
  child: const Text('Üyeleri Gör'),
),

                      ],
                    ),
                  ),

                  /// Katıl / Ayrıl Butonu
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.read<GroupCubit>().toggleJoin(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Arka plan rengi
                        foregroundColor: Colors.white, // Yazı rengi
                        padding: const EdgeInsets.symmetric(
                            vertical: 16), // Buton yüksekliği
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: Text(state.isJoined ? 'Ayrıl' : 'Katıl'),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Moderatörler
                  Text(
                    'Moderatörler',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: group.moderators.map((mod) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              NetworkImage(mod), // mod yerine url varsa
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
