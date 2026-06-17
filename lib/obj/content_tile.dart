import 'package:flutter/material.dart';
import 'package:nadagram/db/models/content.dart';
import 'package:nadagram/db/repositories/content.dart';
import 'package:nadagram/db/repositories/user.dart';

class ContentTile extends StatelessWidget{
  final NadagramContent content;

  const ContentTile({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final NadagramContentRepository nadaRepo = NadagramContentRepository();
    UserRepository repo = UserRepository();
    final isFavorite = repo.getAllFavorites().contains(content.key);
    return Column (
      crossAxisAlignment: .start,
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Image.network(
            content.imagePath,
            fit: BoxFit.cover,
          )),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                content.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              
              IconButton(
                onPressed: () async {
                  if (!isFavorite) {
                    await repo.addNewFavorite(content.key);
                    await nadaRepo.addLikes(content.key, content.likeCount);
                  }
                },
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite
                    ? Colors.red
                    : Colors.grey,
                ),
              ),

              Text(
                content.likeCount.toString(),
                style: Theme.of(context).textTheme.bodyMedium
              )
            ],
          )
        ),

        content.description.isNotEmpty ?
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              content.description,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ) : const SizedBox.shrink(),

        Divider()
      ],
    );
  }
}