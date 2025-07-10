import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/member_status.dart';
import '../cubit/expandable_text_cubit.dart';
import '../cubit/group_cubit.dart';
import '../cubit/group_member_cubit.dart';
import '../cubit/group_member_state.dart';
import '../cubit/group_state.dart';
import '../services/group_service.dart';
import '../widgets/group_member_bottom_sheet.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupCubit()..loadGroup(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<GroupCubit, GroupState>(
            builder: (context, state) {
              switch (state.status) {
                case GroupStatus.loading:
                case GroupStatus.initial:
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
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
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
                  final moderators = group.admins
                      .where((m) => m.memberRole.toLowerCase() == 'admin')
                      .toList();

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KAPAK FOTOĞRAFI + ÜSTTE BAŞLIK + SOL ALTA TAŞAN PROFİL
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Kapak Fotoğrafı
                            SizedBox(
                              height: 280,
                              width: double.infinity,
                              child: Image.network(
                                group.coverUrl ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Grup Detay Başlığı
                            const Positioned(
                              top: 16,
                              left: 16,
                              child: Row(
                                children: [
                                  BackButton(color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Grup Detay',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black54,
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Profil Fotoğrafı - taşan şekilde
                            Positioned(
                              bottom:
                                  -35, // Yüksekliğin yarısı kadar taşıyoruz (yarısı kapakta kalır)
                              left: 16,
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    group.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                group.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                group.category.description,
                                style: const TextStyle(color: Colors.grey),
                              ),

                              const SizedBox(height: 16),
                              //Text(group.description),
                              BlocProvider(
                                create: (_) => ExpandableTextCubit(),
                                child: BlocBuilder<ExpandableTextCubit, bool>(
                                  builder: (context, isExpanded) {
                                    final fullText = group.description +
                                        group.description +
                                        group.description;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          fullText,
                                          maxLines: isExpanded ? null : 2,
                                          overflow: isExpanded
                                              ? TextOverflow.visible
                                              : TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                        if (_isTextTooLong(
                                            fullText)) // kontrol fonksiyonu altta
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.blue,
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                              onPressed: () => context
                                                  .read<ExpandableTextCubit>()
                                                  .toggle(),
                                              child: Text(isExpanded
                                                  ? 'Gizle'
                                                  : 'Devamını Gör'),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Üyeleri Gör Butonu
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${group.admins.length} üye'),
                                  TextButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16)),
                                        ),
                                        builder: (context) {
                                          return BlocProvider(
                                            create: (_) =>
                                                GroupMemberCubit(GroupService())
                                                  ..fetchMembers(group.id ?? 0),
                                            child: BlocBuilder<GroupMemberCubit,
                                                GroupMemberState>(
                                              builder: (context, state) {
                                                if (state
                                                    is GroupMemberLoading) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else if (state
                                                    is GroupMemberLoaded) {
                                                  return GroupMemberBottomSheet(
                                                      members: state.members);
                                                } else if (state
                                                    is GroupMemberError) {
                                                  return Center(
                                                      child:
                                                          Text(state.message));
                                                } else {
                                                  return const SizedBox
                                                      .shrink();
                                                }
                                              },
                                            ),
                                          );
                                        },
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
                                      : () => context
                                          .read<GroupCubit>()
                                          .toggleJoin(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
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
                                      : Text(
                                          _getButtonText(
                                              state.group?.memberStatus),
                                        ),
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Moderatörler
                              if (moderators.isNotEmpty) ...[
                                const Text(
                                  'Moderatörler',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 60,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: moderators.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 8),
                                    itemBuilder: (context, index) {
                                      final mod = moderators[index];
                                      return CircleAvatar(
                                        radius: 24,
                                        backgroundImage: NetworkImage(
                                            mod.company.profileImage),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  bool _isTextTooLong(String text) {
    final span = TextSpan(
      text: text,
      style: const TextStyle(color: Colors.grey),
    );
    final tp = TextPainter(
      text: span,
      maxLines: 2,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: 300); // Ekrana göre ayarla
    return tp.didExceedMaxLines;
  }

  String _getButtonText(MemberStatus? status) {
    switch (status) {
      case MemberStatus.REQUESTED:
        return "İstek Gönderildi";
      case MemberStatus.INVITED:
      case MemberStatus.JOINED:
        return "Katıldın";
      default:
        return "Katıl";
    }
  }
}
