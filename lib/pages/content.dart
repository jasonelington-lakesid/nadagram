import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:nadagram/db/repositories/content.dart';
import 'package:nadagram/obj/content_tile.dart';

class NadagramContentView extends StatelessWidget {
  const NadagramContentView({
    super.key,
  }); 

  @override
  Widget build(BuildContext context) {
    final NadagramContentRepository repo = NadagramContentRepository();
    return ValueListenableBuilder(
      valueListenable: repo.box.listenable(),
      builder: (context, box, _) {
        final contents = box.values.toList();
        print(box.length);
        return ListView.builder(
          itemCount: contents.length,
          itemBuilder: (context, index) {
            return ContentTile(content: contents[index]);
          },
        );
      }
    );
    
  }
}