import '../models/content.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class NadagramContentRepository {
  Box<NadagramContent> get _box => Hive.box<NadagramContent>('Content');

  Future<void> addNewContent(NadagramContent content) async {
    await _box.add(content);
  }

  Future<bool> validateImageAccessible(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final contentType = response.headers['content-type'];
      return response.statusCode == 200 &&
            contentType != null &&
            contentType.startsWith('image/');
    } catch (_) {
      return false;
    }
  }

  Future<void> addLikes(int index) async {
    final content = _box.get(index);

    if (content == null) return;

    content.likeCount = content.likeCount + 1;

    await _box.put(index, content);
  }

  Future<void> removeLikes(int index) async {
    final content = _box.get(index);

    if (content == null) return;

    content.likeCount = content.likeCount - 1;

    await _box.put(index, content);
  }

  List<NadagramContent> getAll() {
    return _box.values.toList();
  }

  List<NadagramContent> getContents(String keyword) {
    final contents = _box.values.toList();

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