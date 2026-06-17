import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:nadagram/db/repositories/content.dart';
import 'package:nadagram/db/repositories/user.dart';
import 'package:nadagram/obj/content_tile.dart';

class NadagramContentView extends StatelessWidget {
  const NadagramContentView({
    super.key,
  }); 

  @override
  Widget build(BuildContext context) {
    final NadagramContentRepository contentRepo = NadagramContentRepository();
    final UserRepository useRepo = UserRepository();
    return ValueListenableBuilder(
      valueListenable: useRepo.box.listenable(),
      builder: (context, box, _) {
        final contents = contentRepo.getAll().reversed.toList();
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