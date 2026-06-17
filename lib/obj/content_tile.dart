import 'package:flutter/material.dart';
import 'package:nadagram/db/models/content.dart';
import 'package:nadagram/db/repositories/content.dart';
import 'package:nadagram/db/repositories/user.dart';

class ContentTile extends StatefulWidget{
  final NadagramContent content;

  const ContentTile({
    super.key,
    required this.content,
  });

  @override
  State<ContentTile> createState() => _ContentTileState();
}

class _ContentTileState extends State<ContentTile> {
  bool descExpanded = false;

  @override
  Widget build(BuildContext context) {
    final NadagramContentRepository nadaRepo = NadagramContentRepository();
    UserRepository repo = UserRepository();
    final isFavorite = repo.getAllFavorites().contains(widget.content.key);
    return Column (
      crossAxisAlignment: .start,
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Image.network(
            widget.content.imagePath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                )
              );
            },
          )),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                widget.content.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              
              IconButton(
                onPressed: () async {
                  if (!isFavorite) {
                    await repo.addNewFavorite(widget.content.key);
                    await nadaRepo.addLikes(widget.content.key, widget.content.likeCount);
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
                widget.content.likeCount.toString(),
                style: Theme.of(context).textTheme.bodyMedium
              )
            ],
          )
        ),

        Column(
          children: [
            widget.content.description.isNotEmpty ?
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.content.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: descExpanded ? null : 2,
                overflow: descExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis
              )
            ) : const SizedBox.shrink(),
            
            if (widget.content.description.length > 100)
              TextButton(
                onPressed: () {
                  setState(() {
                    descExpanded = !descExpanded;
                  });
                }, 
                child: Text(
                  descExpanded
                        ? 'Show Less'
                        : 'Show More'
                )
              )
          ],
        ),

        Divider()
      ],
    );
  }
}
