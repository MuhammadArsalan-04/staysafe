// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/elements/custom_text_button.dart';

import 'custom_image_container.dart';

class AlertNotificationMessageView extends StatelessWidget {
  final String url;
  final String time;
  final bool sendByMe;
  const AlertNotificationMessageView({
    Key? key,
    required this.url,
    required this.time,
    required this.sendByMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              CustomImageContainer(
            height: 0.2 * MediaQuery.of(context).size.height,
            wight: 0.6 * MediaQuery.of(context).size.width,
            radius: 8,
            image: url,
          ),
          CustomTextButton(buttonText: "Start Tracking", onPressed: (){}, textColor: ColorConstants.kPrimaryColor,)
            ],
          ),
        ),
        Container(
          
          child: Text(
            time.toString(),
            style: TextStyle(
              fontSize: 12,
              color: sendByMe ? Colors.black : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
