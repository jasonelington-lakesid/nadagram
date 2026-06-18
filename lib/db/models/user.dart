import 'package:hive_ce/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject{
  @HiveField(0)
  final Set<int> favorited;
  
  @HiveField(1)
  bool isDarkMode = false;

  User(
    {
      required this.favorited,
      required this.isDarkMode,
    }
  );
}