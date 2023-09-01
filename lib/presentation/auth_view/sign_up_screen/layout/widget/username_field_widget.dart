import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_safe_user/infrastructure/providers/username_provider.dart';
import 'package:stay_safe_user/infrastructure/services/user_services.dart';

import '../../../../../configurations/color_constants.dart';
import '../../../../../elements/custom_text.dart';

class UsernameFieldWidget extends StatefulWidget {
  TextEditingController controller;
  TextInputType? textInputType;
  bool isObsecure;
  String hintText;
  String? labelText;
  double? radius;
  IconData? prefixIcon;
  bool? isSuffix;
  String? Function(String?)? validator;

  UsernameFieldWidget({
    super.key,
    required this.controller,
    this.validator,
    this.isObsecure = false,
    this.textInputType,
    required this.hintText,
    this.labelText,
    this.radius,
    this.prefixIcon,
    this.isSuffix = false,
  });

  @override
  State<UsernameFieldWidget> createState() => _UsernameFieldWidgetState();
}

class _UsernameFieldWidgetState extends State<UsernameFieldWidget> {
  bool hasFocus = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsernameProvider>(
      context,
    );
    return Focus(
      onFocusChange: (value) {
        setState(() {
          hasFocus = value;
        });
      },
      child: TextFormField(
        onChanged: (value) async {
          userProvider.setLoadingStatus = true;

          //firebase function
          await userProvider.checkUsername(widget.controller.text.toLowerCase());
          userProvider.setLoadingStatus = false;
        },
        validator: widget.validator == null
            ? null
            : (value) {
                if (userProvider.getUsernameStatus == true) {
                  return 'This username is already taken';
                }
                if (widget.controller.text.contains(' ')) {
                  return 'The username cannot contain spaces';
                }
                return widget.validator!(value);
              },
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        controller: widget.controller,
        obscureText: widget.isObsecure,
        keyboardType: widget.textInputType,
        cursorColor: ColorConstants.kPrimaryColor,
        decoration: InputDecoration(
          label: widget.labelText == null
              ? null
              : CustomText(
                  text: widget.labelText!,
                ),
          labelStyle: hasFocus
              ? const TextStyle(color: ColorConstants.kPrimaryColor)
              : null,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1.2, color: ColorConstants.kPrimaryColor),
            borderRadius: BorderRadius.circular(widget.radius ?? 12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1.2, color: ColorConstants.kPrimaryColor),
            borderRadius: BorderRadius.circular(widget.radius ?? 12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1.2, color: ColorConstants.kPrimaryColor),
            borderRadius: BorderRadius.circular(widget.radius ?? 12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1.2, color: ColorConstants.kPrimaryColor),
            borderRadius: BorderRadius.circular(widget.radius ?? 12),
          ),
          hintText: widget.hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          hintStyle: const TextStyle(
            color: ColorConstants.kgreyColor,
          ),
          prefixIcon: widget.prefixIcon == null
              ? null
              : Icon(
                  widget.prefixIcon,
                  color: Colors.grey,
                ),
          suffixIcon: widget.controller.text.isEmpty
              ? null
              : userProvider.getLoadingStatus
                  ? const CupertinoActivityIndicator(
                      animating: true,
                    )
                  : Icon(
                      userProvider.getUsernameStatus
                          ? Icons.close
                          : Icons.check_circle_outline,
                      color: userProvider.getUsernameStatus
                          ? Colors.red
                          : Colors.green,
                    ),
        ),
      ),
    );
  }
}
