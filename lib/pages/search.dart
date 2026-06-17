import 'package:flutter/material.dart';
import 'package:nadagram/db/models/content.dart';
import 'package:nadagram/db/repositories/content.dart';
import 'package:nadagram/obj/content_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword = '';
  NadagramContentRepository contentRepo = NadagramContentRepository();
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
                setState(() {
                  keyword = value;
                });
              },
            ),

            SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  return ContentTile(content: searchResult[index]);
                }
              )
            ),
          ],
        )
      )
    );
  }
}
