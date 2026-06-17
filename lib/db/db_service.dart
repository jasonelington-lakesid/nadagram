import 'package:hive_ce_flutter/hive_flutter.dart';
import 'models/content.dart';
import 'models/user.dart';

class DatabaseService {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(NadagramContentAdapter());
    Hive.registerAdapter(UserAdapter());

    await Hive.openBox<NadagramContent>('Content');
    await Hive.openBox<User>('User');
  }
}