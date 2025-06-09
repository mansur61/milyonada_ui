import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil'),
          centerTitle: true,
          leading: const BackButton(color: Colors.blue),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final bloc = context.read<ProfileBloc>();

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Profil Görseli
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: const NetworkImage(
                      "https://picsum.photos/200/200?random=2",
                    ),
                  ),
                  const SizedBox(height: 12),

                  // İsim
                  const Text(
                    "Ali Yılmaz",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text("Üye Oldu; 12 Şubat 2024"),

                  const SizedBox(height: 24),

                  // Üye Bilgileri Başlığı
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ÜYE BİLGİLERİ",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const Divider(),

                  const SizedBox(height: 12),

                  // İşletme Bilgileri Başlığı
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "İŞLETME BİLGİLERİ",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Açıklama Alanı
                  TextFormField(
                    maxLines: 2,
                    initialValue: "İş birlikleri üzerine öğrenci tartışma platformu",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Onayla Butonu
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isSubmitting
                          ? null
                          : () => bloc.add(SubmitProfilePressed()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state.isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              "Onayla",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
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
