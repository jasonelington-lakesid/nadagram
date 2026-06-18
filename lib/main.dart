import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nadagram/db/db_service.dart';
import 'package:nadagram/pages/main_page.dart';
import 'package:nadagram/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light
    );
    final darkScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark
    );
    return ValueListenableBuilder(
        valueListenable: themeModeNotifier, 
        builder: (context, themeMode, _) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightScheme,
              appBarTheme: AppBarTheme(
                backgroundColor: lightScheme.surface,
                foregroundColor: lightScheme.onSurface,
                scrolledUnderElevation: 0,
                surfaceTintColor: Colors.transparent,
              )
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkScheme,
              appBarTheme: AppBarTheme(
                backgroundColor: darkScheme.surface,
                foregroundColor: darkScheme.onSurface,
                scrolledUnderElevation: 0,
                surfaceTintColor: Colors.transparent,
              )
            ),
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            home: const MainLayout()
          );
        }
    );
  }
}
