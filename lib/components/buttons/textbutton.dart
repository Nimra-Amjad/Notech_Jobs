import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback onpressed;
  final String text;
  final double width;
  final double height;

  const TextButtonWidget(
      {super.key,
      required this.onpressed,
      required this.text,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 36, 22, 222),
            padding: const EdgeInsets.all(16.0),
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onpressed,
        child: Text(text),
      ),
    );
  }
}
