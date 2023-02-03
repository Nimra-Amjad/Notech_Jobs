import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text,Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: TextStyle(color: Colors.white)),
      backgroundColor: color
    ),
  );
}