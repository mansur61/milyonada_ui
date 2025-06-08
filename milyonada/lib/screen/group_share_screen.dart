import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/group_share/group_share_bloc.dart';
import '../bloc/group_share/group_share_event.dart';
import '../bloc/group_share/group_share_state.dart'; 

class GroupShareScreen extends StatelessWidget {
  const GroupShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupShareBloc(),
      child: const GroupShareView(),
    );
  }
}

class GroupShareView extends StatelessWidget {
  const GroupShareView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GroupShareBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grup İçi Paylaşım'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<GroupShareBloc, GroupShareState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Metin kutusu
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Ne paylaşmak istiyorsunuz?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 3,
                  onChanged: (text) => bloc.add(TextChanged(text)),
                ),
                const SizedBox(height: 16),

                // Galeri - Kamera - Bağlantı
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _iconButton(
                      icon: Icons.photo,
                      label: "Galeri",
                      onTap: () => bloc.add(OpenGallery()),
                    ),
                    _iconButton(
                      icon: Icons.camera_alt,
                      label: "Kamera",
                      onTap: () => bloc.add(OpenCamera()),
                    ),
                    _iconButton(
                      icon: Icons.link,
                      label: "Bağlantı",
                      onTap: () => bloc.add(AddLink()),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Biçimlendirme ve doğrudan paylaşım
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(icon: const Icon(Icons.format_bold), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.format_italic), onPressed: () {}),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(icon: const Icon(Icons.tag), onPressed: () {}),
                        ],
                      ),
                    ),
                  ],
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Doğrudan Paylaşım"),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                const Spacer(),

                // Paylaş butonu
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => bloc.add(SubmitShare()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child:   const Text(
                      'Paylaş',
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _iconButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            radius: 24,
            child: Icon(icon, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
