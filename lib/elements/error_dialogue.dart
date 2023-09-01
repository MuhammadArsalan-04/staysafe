import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';

import 'custom_text.dart';

Future showAlertDialogue(BuildContext context, String title, Color titleColor,
    String contentText, Function onPressed) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: CustomText(fontSize: 14, text: contentText, softwrap: true),
      title: Center(
        child: CustomText(
          text: title,
          color: titleColor,
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onPressed();
          },
          child: CustomText(
            text: 'Okay',
            color: ColorConstants.kPrimaryColor,
          ),
        ),
      ],
    ),
  );
}

Future showErrorDialog(
  BuildContext context, {
  required String message,
  Function? onPressed,
  String? title,
}) async {
  showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) {
        return CupertinoAlertDialog(
          title: title == null
              ? const Text(
                  "Alert!",
                  style: TextStyle(color: Colors.red),
                )
              : Text(
                  title,
                  style: const TextStyle(color: Colors.green),
                ),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: onPressed == null
                    ? () {
                        Navigator.pop(context);
                      }
                    : () => onPressed(),
                child: const Text("Okay"))
          ],
        );
      });
}
