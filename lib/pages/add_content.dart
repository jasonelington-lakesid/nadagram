import 'package:flutter/material.dart';
import 'package:nadagram/db/models/content.dart';
import 'package:nadagram/db/repositories/content.dart';
import 'package:nadagram/external_state/accessible.dart';
import 'package:nadagram/external_state/post.dart';

class AddContent extends StatelessWidget {
  const AddContent({super.key});

  @override
  Widget build(BuildContext context) {
    final NadagramContentRepository contentRepo = NadagramContentRepository();
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final imageController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: 
          Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Adding new Content')
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: .all(20),
                    child: Form (
                      key: formKey,
                      child:
                        Column(
                          children: [
                            Column(
                              children: [
                                TextFormField(
                                  maxLength: 26,
                                  controller: titleController,
                                  decoration: InputDecoration(labelText: 'Title'),
                                  validator: (value) {
                                    postNotifier.value = postNotifier.value.copyWith(isPost: false);
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
                                  textAlignVertical: .top,
                                  decoration: InputDecoration(
                                    labelText: 'Caption/Description',
                                    alignLabelWithHint: true,
                                  ),
                                ),

                                ValueListenableBuilder(
                                  valueListenable: accessibleNotifier, 
                                  builder: (context, error, _) {
                                    postNotifier.value = postNotifier.value.copyWith(isPost: false);
                                    return TextFormField(
                                      controller: imageController,
                                      onChanged: (_) {
                                        accessibleNotifier.value = null;
                                      },
                                      decoration: InputDecoration(labelText: 'Image URL', errorText: error),
                                    );
                                  }
                                )
                              ],
                            ),
                            SizedBox(height: 12),
                            Center(
                              child: ValueListenableBuilder<AddContentNotifier>(
                                valueListenable: postNotifier, 
                                child: Text('Uploading . . .'),
                                builder: (context, state, _) {
                                  return ElevatedButton(
                                    onPressed: state.isPost? null : 
                                        () async {
                                          postNotifier.value = postNotifier.value.copyWith(isPost: true);
                                          if (!formKey.currentState!.validate()) {
                                            postNotifier.value = postNotifier.value.copyWith(isPost: false, isValid: false);
                                            return;
                                          }

                                          if (imageController.text.isEmpty) {
                                            postNotifier.value = postNotifier.value.copyWith(isPost: false, isValid: false);
                                            accessibleNotifier.value = 'Image URL can not be empty';
                                            return;
                                          }

                                          final isAccessilbe = await contentRepo.validateImageAccessible(imageController.text);
                                          if (!isAccessilbe) {
                                            postNotifier.value = postNotifier.value.copyWith(isPost: false, isValid: false);
                                            accessibleNotifier.value = 'Image URL is not valid or accessible.';
                                            return;
                                          }

                                          postNotifier.value = postNotifier.value.copyWith(isPost: true);
                                          
                                          final content = NadagramContent(
                                            title: titleController.text, 
                                            description: descController.text, 
                                            imagePath: imageController.text, 
                                            likeCount: 0
                                          );
                                          try {
                                            await contentRepo.addNewContent(content);
                                          } finally {
                                            postNotifier.value = postNotifier.value.copyWith(
                                              isPost: false, isValid: true
                                            );
                                          }
                                          
                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                        }, 
                                    child: postNotifier.value.isValid 
                                          ? const CircularProgressIndicator()
                                          : Text('POST')
                                  );
                                }
                              )
                            )
                          ]
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    );
  }
}