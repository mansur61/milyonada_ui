import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/grup_yonetimi/group_manager_bloc.dart';
import '../bloc/grup_yonetimi/group_manager_event.dart';
import '../bloc/grup_yonetimi/group_manager_state.dart'; 

class GroupManagementScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Grup Yönetimi', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BackButton(color: Colors.black),
        ),
        body: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sekmeler
                  Row(
                    children: [
                      _tabButton(context, "Genel Ayarlar", 0, state.selectedTab),
                      _tabButton(context, "Üye Yönetimi", 1, state.selectedTab),
                      _tabButton(context, "Başvurular", 2, state.selectedTab),
                    ],
                  ),
                  SizedBox(height: 16),
                  // İçerik
                  if (state.selectedTab == 0) _generalSettingsTab(),
                  if (state.selectedTab == 1) _memberManagementTab(),
                  if (state.selectedTab == 2) _applicationsTab(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _tabButton(BuildContext context, String title, int index, int selectedTab) {
    final isSelected = index == selectedTab;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<GroupBloc>().add(TabChanged(index)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _generalSettingsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _statsRow(),
        SizedBox(height: 16),
        _buildTextField("Ad", controller: nameController),
        _buildTextField("Kategori", controller: categoryController),
        _buildTextField("Açıklama", controller: descriptionController, maxLines: 3),
        SizedBox(height: 24),
        Text("Üyeler", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _iconTile(Icons.person_outline, "Üyeler"),
        _iconTile(Icons.table_chart_outlined, "Başvurular"),
        _iconTile(Icons.shield_outlined, "Moderatör Atama"),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text("Kaydet"),
          ),
        )
      ],
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        Expanded(child: _statBox("Üye Sayısı")),
        SizedBox(width: 12),
        Expanded(child: _statBox("Günlük Aktiflik")),
      ],
    );
  }

  Widget _statBox(String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(child: Text(label)),
    );
  }

  Widget _buildTextField(String label, {TextEditingController? controller, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  Widget _iconTile(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(text),
      trailing: Icon(Icons.chevron_right),
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
    );
  }

  Widget _memberManagementTab() {
    return Center(child: Text("Üye Yönetimi sekmesi"));
  }

  Widget _applicationsTab() {
    return Center(child: Text("Başvurular sekmesi"));
  }
}
