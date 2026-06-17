import '../models/content.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class NadagramContentRepository {
  Box<NadagramContent> get box => Hive.box<NadagramContent>('Content');

  Future<void> addNewContent(NadagramContent content) async {
    await box.add(content);
  }

  List<NadagramContent> getAll() {
    return box.values.toList();
  }
}