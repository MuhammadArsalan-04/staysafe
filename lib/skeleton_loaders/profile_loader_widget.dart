import 'package:flutter/material.dart';

import '../elements/sizes.dart';
import '../elements/skeleton_loader.dart';

class ProfileLoaderWidget extends StatelessWidget {
  const ProfileLoaderWidget({this.height, this.width, this.radius, super.key});
  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SkeletonLoader(
            height: height ?? 50, radius: radius ?? 100, width: width ?? 50),
        kw15,
        Column(
          children:  [
            const SkeletonLoader(height: 12, radius: 20, width: 100),
            k5,
            const SkeletonLoader(height: 12, radius: 20, width: 100),
          ],
        )
      ],
    );
  }
}
