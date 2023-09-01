import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/elements/aler_notification_message_view.dart';
import 'package:stay_safe_user/elements/custom_image_container.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/presentation/safety_app_view/person_tracking/person_tracking_view.dart';

import 'custom_text_button.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final String messageId;
  final String chatListId;
  final bool sendByMe;
  final String time;
  final String senderId;
  final String type;

  const MessageTile(
      {required this.message,
      required this.sendByMe,
      required this.chatListId,
      required this.messageId,
      required this.time,
      required this.senderId,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          sendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        type == "alert"
            ? Column(
                crossAxisAlignment: sendByMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment:
                        sendByMe ? Alignment.centerRight : Alignment.centerLeft,
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      children: [
                        CustomImageContainer(
                          height: 0.2 * MediaQuery.of(context).size.height,
                          wight: 0.6 * MediaQuery.of(context).size.width,
                          radius: 8,
                          image: message,
                        ),
                        CustomTextButton(
                          buttonText: "Start Tracking",
                          onPressed: () {
                            NavigationHelper.pushRoute(context,
                                PersonTrackingView.routeName, senderId);
                          },
                          textColor: ColorConstants.kPrimaryColor,
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment:
                        sendByMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Text(
                      time.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: sendByMe ? Colors.black : Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            : type == "image"
                ? Column(
                    crossAxisAlignment: sendByMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        child: CustomImageContainer(
                          height: 0.2 * MediaQuery.of(context).size.height,
                          wight: 0.6 * MediaQuery.of(context).size.width,
                          radius: 8,
                          image: message,
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
                  )
                : Container(
                    padding: EdgeInsets.only(
                        top: 4,
                        bottom: 1,
                        left: sendByMe ? 0 : 14,
                        right: sendByMe ? 14 : 0),
                    alignment:
                        sendByMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: 0.6 * MediaQuery.of(context).size.width),
                      margin: sendByMe
                          ? const EdgeInsets.only(left: 30)
                          : const EdgeInsets.only(right: 30),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 5, left: 20, right: 10),
                      decoration: BoxDecoration(
                        color: sendByMe
                            ? ColorConstants.kPrimaryColor
                            : Colors.white,
                        borderRadius: sendByMe
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))
                            : const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  height: 1.3,
                                  color: sendByMe ? Colors.white : Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            time.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: sendByMe ? Colors.white60 : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ],
    );
  }
}
