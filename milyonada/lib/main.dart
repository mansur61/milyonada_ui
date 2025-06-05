import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/group_bloc.dart';
import 'screen/group_discovery_screen.dart';
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
        BlocProvider(create: (_) => GroupBloc()..add(LoadGroups())),
        // Diğer bloclar eklenebilir
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grup Uygulaması',
        initialRoute: '/',
        routes: {
          '/': (context) => const GroupCreateScreen(),//GroupDiscoveryScreen(),
          '/create': (context) => const GroupCreateScreen(),
          // diğer sayfalar buraya eklenebilir
        },
      ),
    );
  }
}
