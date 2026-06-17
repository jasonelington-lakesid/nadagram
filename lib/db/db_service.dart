import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:nadagram/db/models/user_setting.dart';
import 'models/content.dart';
import 'models/user.dart';

class DatabaseService {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(NadagramContentAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(UserSettingAdapter());

    await Hive.openBox<NadagramContent>('Content');
    await Hive.openBox<User>('User');
    await Hive.openBox<UserSetting>('UserSetting');
  }
}