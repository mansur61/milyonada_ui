import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'bloc/member_management/member_management_bloc.dart';
import 'bloc/member_management/member_management_event.dart'; 
import 'products/group/group_discovery/view/group_discovery_screen.dart';
import 'screen/group_create_screen.dart';   

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
          GroupDiscoveryScreen(),
         //  GroupDetailScreen(),
           //ProfileScreen(),
          '/create': (context) => const GroupCreateScreen(),
          // diğer sayfalar buraya eklenebilir
        },
      ),
    );
  }
}
