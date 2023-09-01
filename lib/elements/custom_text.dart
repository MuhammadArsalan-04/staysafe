import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  bool? softwrap;
  int? maxLines;
  TextAlign? textAlign;

  CustomText({
    this.color,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    required this.text,
    this.softwrap,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: softwrap,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
