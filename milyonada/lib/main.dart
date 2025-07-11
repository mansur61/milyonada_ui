import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'products/group_detail/cubit/group_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GroupCubit()..loadGroup()),
        
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grup Uygulaması',
        /*initialRoute: '/',
        routes: {
          '/': (context) => 
          //GroupDetailScreen()
          //GroupManagementScreen(),
          GroupDiscoveryScreen(),
         //  GroupDetailScreen(),
           //ProfileScreen(),
          '/create': (context) => const GroupCreateScreen(),
          // diğer sayfalar buraya eklenebilir
        },*/
      ),
    );
  }
}
