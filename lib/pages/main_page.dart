import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:nadagram/db/models/content.dart';
import 'package:nadagram/db/repositories/content.dart';
import 'package:nadagram/db/repositories/user.dart';
import 'package:nadagram/obj/content_tile.dart';
import 'package:nadagram/pages/add_content.dart';
import 'package:nadagram/external_state/theme.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key,});

  @override
  State<MainLayout> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayout> {
  final NadagramContentRepository contentRepo = NadagramContentRepository();
  final UserRepository userRepo = UserRepository();
  Timer? _debounce;
  String keyword = '';
  @override
  Widget build(BuildContext context) {
    List<NadagramContent> searchResult = contentRepo.getContents(keyword).reversed.toList();
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 500;
        final isSuperSmall = constraints.maxWidth < 200;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            leadingWidth: 120,
            leading: !isSmall 
                ? Align (
                  alignment: .center,
                  child: Padding(
                    padding: .only(
                      left: 8,
                    ),
                    child: Text(
                      'Nadagram',
                      style: GoogleFonts.poppins(
                        fontWeight: .bold,
                        fontSize: 18,
                      )
                    )
                  )
                )
                : null,
            title: SizedBox(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Post',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: .circular(12)
                  )
                ),
                onChanged: (value) {
                  _debounce?.cancel();

                  _debounce = Timer(
                    Duration(milliseconds: 300),
                    () {
                      setState(() {
                        keyword = value;
                      });
                    }
                  );
                },
              ),
            ),

            actions: [
              Padding(
                padding: .only(
                  right: 8
                ),
                child: !isSuperSmall
                  ? Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          userRepo.getDarkMode()
                              ? Icons.light_mode
                              : Icons.dark_mode
                        ),
                        onPressed: () async {
                          final isDark = themeModeNotifier.value != ThemeMode.dark;
                          themeModeNotifier.value = isDark
                              ? ThemeMode.dark
                              : ThemeMode.light;
                          userRepo.setDarkMode(isDark);
                          setState(() {});
                        },
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
                  )
                  : null,
              ) 
            ],

          ),

          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: 
                searchResult.isNotEmpty
                  ? ValueListenableBuilder(
                    valueListenable: userRepo.box.listenable(), 
                    builder: (context, box, _) {
                      return ListView.builder(
                        itemCount: searchResult.length,
                        itemBuilder: (context, index) {
                          print('Object Contet Created: $index');
                          return ContentTile(content: searchResult[index]);
                        }
                      );
                    }
                  ) 
                  : Center(
                    child: Text('No Content Available. . .')
                  )
              )
          )
        );
      }
    );
  }
}