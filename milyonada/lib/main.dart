import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/group_bloc.dart';
import 'screen/group_discovery_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grup Keşfet',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => GroupBloc()..add(LoadGroups()),
        child: const GroupDiscoveryScreen(),
      ),
    );
  }
}
