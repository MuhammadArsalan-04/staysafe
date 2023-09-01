import 'package:flutter/material.dart';

import '../configurations/color_constants.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {this.color,
      required this.icon,
      required this.onPressed,
      this.size,
      super.key});

  final Function onPressed;
  final IconData icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(),
      icon: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
