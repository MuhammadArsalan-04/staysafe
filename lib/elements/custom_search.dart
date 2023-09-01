import 'package:flutter/material.dart';

import '../configurations/color_constants.dart';

class CustomSearch extends StatelessWidget {
  CustomSearch({
    this.controller,
    this.hintTextColor,
    this.hintText,
    this.radius,
    this.isBackgroundColored = false,

    this.textfieldBackgroundColor,
    this.isTextFieldEnabled = false,
    this.prefixIcon,
    this.prefixIconSize,
    this.prefixIconColor,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixIconSize,
    this.onsuffixIconTap,
  });
  String? hintText;
  double? radius;
  Function? onsuffixIconTap;
  IconData? prefixIcon;
  Color? prefixIconColor;
  double? prefixIconSize;
  Color? suffixIconColor;
  double? suffixIconSize;
  bool isTextFieldEnabled;
  Color? hintTextColor;
  Color? textfieldBackgroundColor;
  bool? isBackgroundColored;

  IconData? suffixIcon;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 15),
      child: TextFormField(
        cursorColor: ColorConstants.kPrimaryColor,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            fillColor: textfieldBackgroundColor ?? ColorConstants.kgreyColor,
            filled: isBackgroundColored,
            enabled: isTextFieldEnabled,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorConstants.kgreyColor),
              borderRadius: BorderRadius.circular(radius ?? 12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorConstants.kgreyColor),
              borderRadius: BorderRadius.circular(radius ?? 12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorConstants.kgreyColor),
              borderRadius: BorderRadius.circular(radius ?? 12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorConstants.kgreyColor),
              borderRadius: BorderRadius.circular(radius ?? 12),
            ),
            hintText: hintText,
            contentPadding: const EdgeInsets.only(
              left: 30,
              top: 22,
              right: 30,
              bottom: 22,
            ),
            hintStyle: TextStyle(
              color: hintTextColor,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(
                    prefixIcon,
                    color: prefixIconColor ?? Colors.grey,
                    size: prefixIconSize ?? 26,
                  ),
            suffixIcon: suffixIcon == null
                ? null
                : IconButton(
                    padding: const EdgeInsets.only(right: 10),
                    onPressed:
                        onsuffixIconTap == null ? null : onsuffixIconTap!(),
                    icon: Icon(suffixIcon),
                    iconSize: suffixIconSize,
                    color: suffixIconColor,
                  )),
      ),
    );
  }
}
