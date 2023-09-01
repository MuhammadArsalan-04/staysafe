// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import 'package:stay_safe_user/configurations/api_key.dart';

import '../../../../../configurations/color_constants.dart';

class TextFieldView extends StatelessWidget {
  TextEditingController? controller;
  Function? onLocationTap;
  TextInputType? textInputType;
  String hintText;
  String? labelText;
  double? radius;
  IconData? prefixIcon;
  bool? isSuffix;
  IconData? suffixIcon;
  double? iconSize;
  int? maxLines;
  Function(String)? validator;

  TextFieldView({
    this.controller,
    this.textInputType,
    required this.hintText,
    this.labelText,
    this.radius,
    this.prefixIcon,
    this.isSuffix = false,
    this.suffixIcon,
    this.iconSize,
    this.maxLines,
    this.onLocationTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
      controller: controller,
      validator: validator == null ? null : (value) => validator!(value!),
      keyboardType: textInputType,
      cursorColor: ColorConstants.kPrimaryColor,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 1.2, color: ColorConstants.kPrimaryColor),
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 1.2, color: ColorConstants.kPrimaryColor),
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 1.2, color: ColorConstants.kPrimaryColor),
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 1.2, color: ColorConstants.kPrimaryColor),
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
        hintStyle: const TextStyle(
          color: ColorConstants.kgreyColor,
        ),
        prefixIcon: prefixIcon == null
            ? null
            : Icon(
                prefixIcon,
                color: Colors.grey,
              ),
        suffixIcon: isSuffix == false
            ? null
            : IconButton(
                onPressed:
                    onLocationTap == null ? null : () => onLocationTap!(),
                icon: Icon(
                  suffixIcon,
                  color: ColorConstants.kPrimaryColor,
                ),
              ),
      ),
    );
  }
}

class GoogleAutoCompleteFieldWidget extends StatelessWidget {
  TextEditingController controller;
  Function? onLocationTap;
  TextInputType? textInputType;
  String hintText;
  String? labelText;
  double? radius;
  IconData? prefixIcon;
  bool? isSuffix;
  IconData? suffixIcon;
  double? iconSize;
  int? maxLines;
  Function(String)? validator;

  GoogleAutoCompleteFieldWidget({
    Key? key,
    required this.controller,
    this.onLocationTap,
    this.textInputType,
    required this.hintText,
    this.labelText,
    this.radius,
    this.prefixIcon,
    this.isSuffix,
    this.suffixIcon,
    this.iconSize,
    this.maxLines,
    this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        // cursorColor: ColorConstants.kPrimaryColor,
        googleAPIKey: ApiKey.GOOOGLE_API_KEY,
        inputDecoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1.2, color: ColorConstants.kPrimaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1.2, color: ColorConstants.kPrimaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1.2, color: ColorConstants.kPrimaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1.2, color: ColorConstants.kPrimaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1.2, color: ColorConstants.kPrimaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          hintStyle: const TextStyle(
            color: ColorConstants.kgreyColor,
          ),
          prefixIcon: prefixIcon == null
              ? null
              : Icon(
                  prefixIcon,
                  color: Colors.grey,
                ),
          suffixIconColor: ColorConstants.kPrimaryColor,
          suffixIcon: isSuffix == false
              ? null
              : IconButton(
                  onPressed:
                      onLocationTap == null ? null : () => onLocationTap!(),
                  icon: Icon(
                    suffixIcon,
                    color: ColorConstants.kPrimaryColor,
                  ),
                ),
        ),
        debounceTime: 800,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          
        },
        itmClick: (Prediction prediction) {
          controller.text = prediction.description!;
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length));
        });
  }
}
