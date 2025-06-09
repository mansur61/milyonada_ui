import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/grup_discovery/group_bloc.dart'; 
import 'bloc/member_management/member_management_bloc.dart';
import 'bloc/member_management/member_management_event.dart';
import 'screen/form_screen.dart';
import 'screen/group_create_screen.dart';
import 'screen/group_detail_screen.dart';
import 'screen/group_management_screen.dart';
import 'screen/group_profile_edit_screen.dart';
import 'screen/group_share_screen.dart'; 
import 'screen/member_management_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GroupBloc()..add(LoadGroups())),
        BlocProvider(create: (_) => MemberBloc()..add(LoadMembers())), // ✅ EKLENDİ

        // Diğer bloclar eklenebilir
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grup Uygulaması',
        initialRoute: '/',
        routes: {
          '/': (context) => 
          //GroupDetailScreen()
          //GroupManagementScreen(),
           GroupProfileEditScreen(),
          '/create': (context) => const GroupCreateScreen(),
          // diğer sayfalar buraya eklenebilir
        },
      ),
    );
  }
}
