import 'package:flutter/material.dart';

import 'custom_text.dart';

showSnackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(

      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        content: CustomText(
          text: message,
        ),
      ),
    );
}
