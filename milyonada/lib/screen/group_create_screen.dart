import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/group_create/group_create_bloc.dart';
import '../bloc/group_create/group_create_event.dart';
import '../bloc/group_create/group_create_state.dart';
import 'widgets/group_privacy_option.dart';

class GroupCreateScreen extends StatelessWidget {
  const GroupCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupCreateBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AnotherScreen()),
                  );*/
                },
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              const SizedBox(width: 10),
              const Text('Grup Oluştur'),
            ],
          ),
        ),
        body: const GroupCreateForm(),
      ),
    );
  }
}

class GroupCreateForm extends StatelessWidget {
  const GroupCreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GroupCreateBloc>();

    return BlocBuilder<GroupCreateBloc, GroupCreateState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Grup Adı'),
              const SizedBox(height: 8),
              TextField(
                onChanged: (val) => bloc.add(GroupNameChanged(val)),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Grup adı',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Kategori'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: state.category ?? "Kategori Seç",
                items: [
                  'Kategori Seç',
                  'Kitap',
                  'Spor',
                  'Yazılım',
                  'Fotoğrafçılık'
                ]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => bloc.add(GroupCategoryChanged(val!)),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              const Text('Gizlilik Türü'),
              const SizedBox(height: 8),
              GroupPrivacyOption(
                title: 'Açık',
                description: 'Herkes grubu görebilir ve katılabilir.',
                icon: Icons.public,
                isSelected: state.privacy == 'Açık',
                onTap: () => bloc.add(GroupPrivacyChanged('Açık')),
              ),
              GroupPrivacyOption(
                title: 'Onaylı',
                description:
                    'Gruba katılmak isteyenlerin isteği onaylanmalıdır.',
                icon: Icons.verified_user,
                isSelected: state.privacy == 'Onaylı',
                onTap: () => bloc.add(GroupPrivacyChanged('Onaylı')),
              ),
              GroupPrivacyOption(
                title: 'Kapalı',
                description: 'Grup gizlidir. Yalnızca davetliler katılabilir.',
                icon: Icons.lock,
                isSelected: state.privacy == 'Kapalı',
                onTap: () => bloc.add(GroupPrivacyChanged('Kapalı')),
              ),
              const SizedBox(height: 16),
              const Text('Açıklama'),
              const SizedBox(height: 8),
              TextField(
                maxLines: 3,
                onChanged: (val) => bloc.add(GroupDescriptionChanged(val)),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Grup açıklaması',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Profil Görselleri'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => bloc.add(GroupImage1Selected()),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: state.image1Path == null
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image),
                                    Text('Görsel Yükle'),
                                  ],
                                )
                              : const Icon(Icons.check, color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => bloc.add(GroupImage2Selected()),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: state.image2Path == null
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image),
                                    Text('Görsel Yükle'),
                                  ],
                                )
                              : const Icon(Icons.check, color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16), // Yatayda boşluk
                child: SizedBox(
                  width: double
                      .infinity, // Buton genişliği ekranın tamamı, ama padding sayesinde yanlarda boşluk olur
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Butonun mavi rengi
                    ),
                    onPressed: state.isSubmitting
                        ? null
                        : () => bloc.add(GroupFormSubmitted()),
                    child: state.isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Oluştur',
                            style: TextStyle(
                              color: Colors
                                  .white, // Yazı rengi beyaz olsun ki mavi üzerinde görünür olsun
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
