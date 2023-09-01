import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({
    required this.height,
    required this.radius,
    required this.width,
    super.key,
  });
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 225, 223, 223),
      highlightColor: Colors.white,
      direction: ShimmerDirection.ltr,
      enabled: true,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 249, 243, 243),
            borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}
