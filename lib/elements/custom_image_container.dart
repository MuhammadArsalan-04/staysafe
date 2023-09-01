import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageContainer extends StatefulWidget {
  final double height;
  final double wight;
  final double radius;
  final String image;

  const CustomImageContainer(
      {super.key,
      required this.height,
      required this.wight,
      required this.radius,
      required this.image});

  @override
  State<CustomImageContainer> createState() => _CustomImageContainerState();
}

class _CustomImageContainerState extends State<CustomImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.wight,
      constraints:
          BoxConstraints(maxWidth: 0.6 * MediaQuery.of(context).size.width),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: widget.image,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Container(
            width: 50,
            height: 50,
            child: Center(
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
