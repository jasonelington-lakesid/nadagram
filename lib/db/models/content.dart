import 'package:hive_ce/hive.dart';

part 'content.g.dart';

@HiveType(typeId: 0)
class NadagramContent {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;
  
  @HiveField(2)
  final String imagePath;

  @HiveField(3)
  final int likeCount;

  NadagramContent({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.likeCount,
  });
}