import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/group_bloc.dart'; 
import 'bloc/uye_yonetimi/uye_bloc.dart';
import 'bloc/uye_yonetimi/uye_event.dart';
import 'screen/group_create_screen.dart';
import 'screen/group_detail_screen.dart';
import 'screen/uye_yonetimi_screen.dart'; 

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
          MemberScreen(),
           
          '/create': (context) => const GroupCreateScreen(),
          // diğer sayfalar buraya eklenebilir
        },
      ),
    );
  }
}
