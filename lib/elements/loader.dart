import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';

class Loader extends StatelessWidget {
  const Loader({this.color, this.size, super.key});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
          color: color ?? ColorConstants.kPrimaryColor, size: size ?? 50),
    );
  }
}
