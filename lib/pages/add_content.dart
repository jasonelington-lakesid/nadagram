import 'package:flutter/material.dart';
import 'package:nadagram/db/models/content.dart';
import 'package:nadagram/db/repositories/content.dart';

class AddContent extends StatelessWidget {
  const AddContent({super.key});

  @override
  Widget build(BuildContext context) {
    final NadagramContentRepository repo = NadagramContentRepository();
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final imageController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .all(20),
          child: Column(
            children: [
              Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Title')
                  ),
                  TextField(
                    controller: descController,
                    decoration: InputDecoration(labelText: 'Caption/Description'),
                  ),
                  TextField(
                    controller: imageController,
                    decoration: InputDecoration(labelText: 'Image URL'),
                  )
                ],
              ),
              Center(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final content = NadagramContent(
                          title: titleController.text, 
                          description: descController.text, 
                          imagePath: imageController.text, 
                          likeCount: 0
                        );

                      await repo.addNewContent(content);
                      if (!context.mounted) return;
                      Navigator.pop(context);
                      }, 
                      child: Text('POST!')
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
                      child: Text('CANCEL'))
                  ],
                ) 
              )
            ]
        )
        )
      )
    );
  }
}