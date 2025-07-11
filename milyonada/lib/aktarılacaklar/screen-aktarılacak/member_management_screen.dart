import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc-aktarılacak/member_management/member_management_bloc.dart';
import '../bloc-aktarılacak/member_management/member_management_event.dart';
import '../bloc-aktarılacak/member_management/member_management_state.dart';

class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MemberBloc()..add(LoadMembers()),
      child: Scaffold(
        appBar: AppBar(title: Text("Üye Yönetimi")),
        body: BlocBuilder<MemberBloc, MemberState>(
          builder: (context, state) {
            if (state is MemberLoaded) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                        "Lütfen kurallara uyan her üyeye saygılı ve adil davranın."),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.members.length,
                      itemBuilder: (context, index) {
                        final member = state.members[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(member.initials),
                          ),
                          title: Text(member.name),
                          trailing: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                              context
                                  .read<MemberBloc>()
                                  .add(ShowMemberOptions(member));
                              _showMemberOptions(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

void _showMemberOptions2(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white, // ← Arka planı açık yaptık
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Builder(
        builder: (context) {
          return BlocBuilder<MemberBloc, MemberState>(
            builder: (context, state) {
              if (state is MemberLoaded && state.selectedMember != null) {
                final member = state.selectedMember!;
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildOption("Profil görüntüle", () {
                        Navigator.pop(context);
                        print("Profil görüntülendi: ${member.name}");
                      }),
                      _buildOption("Mesaj yaz", () {
                        Navigator.pop(context);
                        print("Mesaj yaz: ${member.name}");
                      }),
                      _buildOption("Yetki ver", () {
                        Navigator.pop(context);
                        print("Yetki ver: ${member.name}");
                      }),
                      _buildOption("Gruptan çıkar", () {
                        Navigator.pop(context);
                        print("Gruptan çıkar: ${member.name}");
                      }),
                      _buildOption("Engelle", () {
                        Navigator.pop(context);
                        print("Engelle: ${member.name}");
                      }),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Onayla"),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        },
      );
    },
  );
}


//web için
void _showMemberOptions(BuildContext context) {
  final memberState = context.read<MemberBloc>().state;
  if (memberState is MemberLoaded && memberState.selectedMember != null) {
    final member = memberState.selectedMember!;

    showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDialogOption(context, "Profil görüntüle", () {
                      Navigator.pop(context);
                      print("Profil görüntülendi: ${member.name}");
                    }),
                    _buildDialogOption(context, "Mesaj yaz", () {
                      Navigator.pop(context);
                      print("Mesaj yaz: ${member.name}");
                    }),
                    _buildDialogOption(context, "Yetki ver", () {
                      Navigator.pop(context);
                      print("Yetki ver: ${member.name}");
                    }),
                    _buildDialogOption(context, "Gruptan çıkar", () {
                      Navigator.pop(context);
                      print("Gruptan çıkar: ${member.name}");
                    }),
                    _buildDialogOption(context, "Engelle", () {
                      Navigator.pop(context);
                      print("Engelle: ${member.name}");
                    }),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Onayla"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

//web için
Widget _buildDialogOption(BuildContext context, String text, VoidCallback onTap) {
  return ListTile(
    title: Text(text,textAlign: TextAlign.center,),
    onTap: onTap,
  );
}


 Widget _buildOption(String text, VoidCallback onTap) {
  return ListTile(
    title: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black, // Yazı rengini siyah yap
        ),
      ),
    ),
    onTap: onTap,
  );
}

}
