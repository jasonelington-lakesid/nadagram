import '../models/content.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class NadagramContentRepository {
  Box<NadagramContent> get box => Hive.box<NadagramContent>('Content');

  Future<void> addNewContent(NadagramContent content) async {
    await box.add(content);
  }

  Future<void> addLikes(int index) async {
    final content = box.get(index);

    if (content == null) return;

    content.likeCount = content.likeCount + 1;

    await box.put(index, content);
  }

  Future<void> removeLikes(int index) async {
    final content = box.get(index);

    if (content == null) return;

    content.likeCount = content.likeCount - 1;

    await box.put(index, content);
  }

  List<NadagramContent> getAll() {
    return box.values.toList();
  }

  List<NadagramContent> getContents(String keyword) {
    final contents = box.values.toList();

    final filteredContent = contents.where(
      (content) {
        final query = keyword.toLowerCase();
        return content.title.toLowerCase().contains(query) ||
          (content.description.toLowerCase().contains(query));
      }
    ).toList();

    return filteredContent;
  }
}