import '../models/content.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class NadagramContentRepository {
  Box<NadagramContent> get box => Hive.box<NadagramContent>('Content');

  Future<void> addNewContent(NadagramContent content) async {
    await box.add(content);
  }

  Future<void> addLikes(int index, int likeCount) async {
    final content = box.get(index);

    if (content == null) return;

    content.likeCount = likeCount;

    await box.put(index, content);
  }

  List<NadagramContent> getAll() {
    return box.values.toList();
  }
}