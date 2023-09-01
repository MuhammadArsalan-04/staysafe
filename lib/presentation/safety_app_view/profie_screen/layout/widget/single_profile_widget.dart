import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/configurations/res.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/elements/sizes.dart';

class SingleProfileWidget extends StatelessWidget {
  const SingleProfileWidget(
      {this.iconSize,
      this.fontSize,
      this.fontWeight,
      this.icon,
      this.iconColor,
      required this.text,
      this.textColor,
      this.onTap,
      this.isImageIcon = false,
      this.iconPath,
      this.suffix,
      super.key});
  final IconData? icon;
  final bool isImageIcon;
  final Widget? suffix;
  final String text;
  final Color? textColor;
  final Color? iconColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final String? iconPath;
  final double? iconSize;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: InkWell(
            onTap: onTap != null ? () => onTap!() : null,
            splashColor: ColorConstants.kgreyColor.withOpacity(0.08),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isImageIcon
                    ? ImageIcon(
                        size: iconSize ?? 16,
                        color: iconColor,
                        AssetImage(iconPath!))
                    : Icon(
                        icon,
                        size: iconSize ?? 16,
                        color: iconColor,
                      ),
                kw10,
                CustomText(
                  text: text,
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ), 
                if(suffix != null)
                const Spacer(),
                if(suffix != null)
                suffix!
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1.2,
        ),
      ],
    );
  }
}
