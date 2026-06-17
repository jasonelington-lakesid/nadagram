import 'package:flutter/material.dart';
import 'package:nadagram/db/models/content.dart';
import 'package:nadagram/db/repositories/content.dart';

class AddContent extends StatelessWidget {
  const AddContent({super.key});

  @override
  Widget build(BuildContext context) {
    final NadagramContentRepository contentRepo = NadagramContentRepository();
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final imageController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .all(20),
          child: 
            Form (
              key: formKey,
              child:
                Column(
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(labelText: 'Title'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Title can not be empty.';
                            }
                            return null;
                          },
                        ),
                        
                        TextFormField(
                          minLines: 4,
                          maxLines: 4,
                          controller: descController,
                          decoration: InputDecoration(labelText: 'Caption/Description'),
                        ),

                        TextFormField(
                          controller: imageController,
                          decoration: InputDecoration(labelText: 'Image URL'),
                          validator: (value)  {
                            if (value == null || value.trim().isEmpty) {
                              return 'Image URL can not be empty.';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                    Center(
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              
                              final content = NadagramContent(
                                title: titleController.text, 
                                description: descController.text, 
                                imagePath: imageController.text, 
                                likeCount: 0
                              );

                            await contentRepo.addNewContent(content);
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
      )
    );
  }
}