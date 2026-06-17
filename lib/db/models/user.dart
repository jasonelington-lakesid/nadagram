import 'package:hive_ce/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject{
  @HiveField(0)
  final Set<int> favorited;

  User({required this.favorited});
}