import 'package:flutter/material.dart';

class AddContentNotifier {
  final bool isPost;
  final bool isValid;

  const AddContentNotifier({
    required this.isPost,
    required this.isValid,
  });

  AddContentNotifier copyWith({
    bool? isPost,
    bool? isValid,
  }) {
    return AddContentNotifier(
      isPost: isPost ?? this.isPost,
      isValid: isValid ?? this.isValid,
    );
  }
}

final postNotifier = ValueNotifier(
  const AddContentNotifier(
    isPost: false, 
    isValid: false,
  )
);