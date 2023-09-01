import 'package:flutter/material.dart';
import 'package:stay_safe_user/presentation/safety_app_view/notification_screen/layout/body.dart';

import '../../../configurations/color_constants.dart';
import '../../../elements/custom_text.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});
  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.kPrimaryColor,
        title: CustomText(
          text: 'Notifications',
          fontWeight: FontWeight.w500,
        ),
      ),
      body:  SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: NotificationViewBody(),
      )),
    );
  }
}
