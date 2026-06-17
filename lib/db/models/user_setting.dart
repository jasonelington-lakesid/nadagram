import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'user_setting.g.dart';

@HiveType(typeId: 2)
class UserSetting extends HiveObject{
  @HiveField(0)
  final bool darkMode;

  UserSetting({
    required this.darkMode
  });
}