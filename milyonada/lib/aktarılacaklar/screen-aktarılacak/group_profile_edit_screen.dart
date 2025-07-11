import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc-aktarılacak/group_profile/group_profile_bloc.dart';
import '../bloc-aktarılacak/group_profile/group_profile_event.dart';
import '../bloc-aktarılacak/group_profile/group_profile_state.dart';

class GroupProfileEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupProfileBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Grup Profili Düzenle"),
          leading: BackButton(),
        ),
        body: BlocBuilder<GroupProfileBloc, GroupProfileState>(
          builder: (context, state) {
            final bloc = context.read<GroupProfileBloc>();

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Grup Adı'),
                    onChanged: (val) => bloc.add(GroupNameChanged(val)),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(labelText: 'Kategori'),
                    onChanged: (val) => bloc.add(CategoryChanged(val)),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Açıklama',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) => bloc.add(DescriptionChanged(val)),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () => bloc.add(ChangeImagePressed()),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    child: Text("Görseli Değiştir"),
  ),
),

                  SizedBox(height: 10),
                  SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: state.isSubmitting
        ? null
        : () => bloc.add(SavePressed()),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[300],
      foregroundColor: Colors.black,
    ),
    child: state.isSubmitting
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          )
        : Text("Kaydet"),
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
