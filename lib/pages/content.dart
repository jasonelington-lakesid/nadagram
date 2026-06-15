import 'package:flutter/material.dart';
import 'package:nadagram/db/repositories/content.dart';
import 'package:nadagram/obj/content_tile.dart';

class NadagramContentView extends StatelessWidget {
  const NadagramContentView({
    super.key,
  }); 

  @override
  Widget build(BuildContext context) {
    final NadagramContentRepository repo = NadagramContentRepository();
    final contents = repo.getAll();
    return ListView.builder(
      itemCount: contents.length,
      itemBuilder: (context, index) {
        return ContentTile(content: contents[index]);
      },
    );
  }
}