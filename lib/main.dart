import 'package:flutter/material.dart';
import 'package:nadagram/db/db_service.dart';
import 'package:nadagram/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MainLayout()
    );
  }
}
