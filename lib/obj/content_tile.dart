import 'package:flutter/material.dart';
import 'package:nadagram/db/models/content.dart';

class ContentTile extends StatelessWidget{
  final NadagramContent content;

  const ContentTile({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column (
      crossAxisAlignment: .start,
      children: [
        Image.network(content.imagePath),

        Padding(
          padding: const EdgeInsets.all(8 ),
          child: Row(
            children: [
              Text(
                content.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite),
              ),
              Text(
                content.likeCount.toString(),
                style: Theme.of(context).textTheme.bodyMedium
              )
            ],
          )
        ),

        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            content.description,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        )
      ],
    );
  }
}