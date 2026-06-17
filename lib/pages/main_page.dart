import 'package:flutter/material.dart';
import 'package:nadagram/db/repositories/content.dart';
import 'package:nadagram/pages/add_content.dart';
import 'package:nadagram/pages/content.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key,});

  @override
  State<MainLayout> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayout> {
  final NadagramContentRepository repo = NadagramContentRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: SearchBar(
          hintText: 'Search for Title/Captions'
        ),
        actions: [
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