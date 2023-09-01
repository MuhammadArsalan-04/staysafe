import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../configurations/res.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({this.height, this.width, super.key});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        Res.kLogo,
        height: height ?? 100,
        width: width ?? 100,
      ),
    );
  }
}
