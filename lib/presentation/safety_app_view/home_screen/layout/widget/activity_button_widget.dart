import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/elements/sizes.dart';

class ActivityButtonWidget extends StatelessWidget {
  ActivityButtonWidget({required this.image, required this.text, super.key});
  String image;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: ColorConstants.kGradientColor,),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageIcon(
                AssetImage(image),
                color: Colors.white,
                size: 30,
              ),
              kw15,
              CustomText(
                text: text,
                color: Colors.white,
              ),
            ],
          ),
          const Spacer(),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                width: 100,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    image,
                    color: Colors.white.withOpacity(0.3),
                    fit: BoxFit.cover,
                    height: 110,
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
