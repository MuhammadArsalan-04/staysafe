import 'package:flutter/material.dart';

import '../../../../../configurations/color_constants.dart';

class ProfileTextFieldWidget extends StatefulWidget {
  TextEditingController? controller;
  TextInputType? textInputType;
  bool isObsecure;
  double? radius;
  bool? readOnly;
  String? initialValue;
  bool? showSuffix;
  ProfileTextFieldWidget(
      {this.controller,
      this.isObsecure = false,
      this.showSuffix = false,
      this.textInputType,
      this.radius,
      this.initialValue,
      this.readOnly = false,
      super.key});

  @override
  State<ProfileTextFieldWidget> createState() => _ProfileTextFieldWidgetState();
}

class _ProfileTextFieldWidgetState extends State<ProfileTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      cursorColor: ColorConstants.kPrimaryColor,
      initialValue: widget.initialValue,
      readOnly: widget.readOnly!,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 1.2, color: ColorConstants.kPrimaryColor),
          borderRadius: BorderRadius.circular(widget.radius ?? 12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 1.2, color: ColorConstants.kPrimaryColor),
          borderRadius: BorderRadius.circular(widget.radius ?? 12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 1.2, color: ColorConstants.kPrimaryColor),
          borderRadius: BorderRadius.circular(widget.radius ?? 12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 1.2, color: ColorConstants.kPrimaryColor),
          borderRadius: BorderRadius.circular(widget.radius ?? 12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        hintStyle: const TextStyle(
          color: ColorConstants.kgreyColor,
        ),
        suffixIcon: widget.showSuffix == false
            ? null
            : IconButton(
                onPressed: changgeEnableStatus,
                icon: Icon(
                  widget.readOnly! ? Icons.edit : Icons.edit_off,
                ),
              ),
      ),
    );
  }

  void changgeEnableStatus() {
    setState(() {
      widget.readOnly = !widget.readOnly!;
    });
  }
}
