
import 'package:flutter/material.dart';

mySnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 1),
  ));
}