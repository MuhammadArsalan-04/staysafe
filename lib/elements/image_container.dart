// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  ImageContainer({
    Key? key,
    this.height = 120,
    this.width = 120,
    required this.imageUrl,
    this.radius = 10,
    this.fit,
  }) : super(key: key);
  double height;
  double width;
  String imageUrl;
  double radius;
  BoxFit? fit ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(
          imageUrl,
          fit: fit ?? BoxFit.fitWidth,
        ),
      ),
    );
  }
}
