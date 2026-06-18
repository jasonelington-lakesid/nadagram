import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nadagram/db/repositories/content.dart';
import 'package:nadagram/pages/add_content.dart';
import 'package:nadagram/pages/content.dart';
import 'package:nadagram/pages/search.dart';
import 'package:nadagram/theme/theme.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key,});

  @override
  State<MainLayout> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayout> {
  final NadagramContentRepository contentRepo = NadagramContentRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Nadagram',
          style: GoogleFonts.poppins(
            fontWeight: .bold,
            fontSize: 24,
          )
        ),
        actions: [
          IconButton(
            icon: themeModeNotifier.value == ThemeMode.dark
                      ? Icon(Icons.dark_mode)
                      : Icon(Icons.light_mode),
            onPressed: () {
              themeModeNotifier.value = themeModeNotifier.value == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark;
            },
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage()
                )
              );
            },
            icon: Icon(Icons.search)
          ),

          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddContent()
                )
              ); 

              setState(() {});
            },
            icon: Icon(Icons.add)
          ),
        ]
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: 
            NadagramContentView()
          )
      )
    );
  }
}