import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:nadagram/db/models/content.dart';
import 'package:nadagram/db/repositories/content.dart';
import 'package:nadagram/db/repositories/user.dart';
import 'package:nadagram/obj/content_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? _debounce;
  String keyword = '';
  NadagramContentRepository contentRepo = NadagramContentRepository();
  UserRepository userRepo = UserRepository();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<NadagramContent> searchResult = contentRepo.getContents(keyword).reversed.toList();
    return  Scaffold(
      appBar: AppBar(
        title: Text('Search')
      ),

      body: Padding(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by Title or Description . . .',
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

            SizedBox(height: 12),

            searchResult.isNotEmpty
            ? Expanded(
                child: ValueListenableBuilder(
                  valueListenable: userRepo.box.listenable(), 
                  builder: (context, box, _) {
                    return ListView.builder(
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) {
                        return ContentTile(content: searchResult[index]);
                      }
                    );
                  }
                )
            )
            : Center(
              child: Text('No Title / Description found.\n Try using new keywords.')
            ),
          ],
        )
      )
    );
  }
}
