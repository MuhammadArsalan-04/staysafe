import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/configurations/res.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/elements/sizes.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/presentation/safety_app_view/notification_screen/notification_view.dart';

class UserDetailsWidgetView extends StatelessWidget {
  String? userName;
  Function? onTap;
  String? imageUrl;

  UserDetailsWidgetView({this.imageUrl, this.onTap, this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(imageUrl!),
        ),
        kw10,
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Hello!',
              fontSize: 16,
              color: ColorConstants.kBlackColor,
              fontWeight: FontWeight.w500,
            ),
            CustomText(
              text: userName!,
              fontSize: 14,
              color: ColorConstants.kgreyColor,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            NavigationHelper.pushRoute(context, NotificationView.routeName);
          },
          icon: const Icon(
            Icons.notifications_none_outlined,
            size: 32,
          ),
        )
      ],
    );
  }
}

/*

Positioned(
              right: 4,
              top: 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.red,
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: CustomText(
                  text: '1',
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  color: ColorConstants.kBadgeTextColor,
                ),
              ),
            ),
 */