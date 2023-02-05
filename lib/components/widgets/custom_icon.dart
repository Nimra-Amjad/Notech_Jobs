import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double? iconSize;
  const CustomIcon(
      {Key? key, required this.icon, required this.iconColor, this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: iconColor,
      size: iconSize,
    );
  }
}
