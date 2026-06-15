import '../models/content.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class NadagramContentRepository {
  Box<NadagramContent> get _box => Hive.box<NadagramContent>('Content');

  Future<void> addNewContent(NadagramContent content) async {
    await _box.add(content);
  }

  List<NadagramContent> getAll() {
    return _box.values.toList();
  }
}