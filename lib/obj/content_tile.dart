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

class _ContentTileState extends State<ContentTile> with AutomaticKeepAliveClientMixin {
  bool descExpanded = false;
  bool isAnimate = false;

  void _animateOnPressed() async {
    setState(() {
      isAnimate = true;
    });

    await Future.delayed(const Duration(milliseconds: 200));

    if(mounted) {
      setState(() {
        isAnimate = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final NadagramContentRepository contentRepo = NadagramContentRepository();
    UserRepository userRepo = UserRepository();
    final isFavorite = userRepo.getAllFavorites().contains(widget.content.key);
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
            errorBuilder: (context, error, stackTrace) {
              return Column(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.broken_image),
                  Text(
                    'Image could not be loaded. . .',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              );
            },
          )
        ),

        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                widget.content.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              
              AnimatedScale(
                scale: isAnimate ? 1.3 : 1.0, 
                duration: const Duration(milliseconds: 200),
                child: IconButton(
                  onPressed: () async {
                    if (!isFavorite) {
                      _animateOnPressed();
                      await userRepo.addNewFavorite(widget.content.key);
                      await contentRepo.addLikes(widget.content.key);
                    } else {
                      await userRepo.removeFavorite(widget.content.key);
                      await contentRepo.removeLikes(widget.content.key);
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite
                      ? Colors.red
                      : Colors.grey,
                  ),
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
                style: Theme.of(context).textTheme.bodyLarge,
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
