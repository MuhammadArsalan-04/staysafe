import 'package:flutter/material.dart';
import 'package:stay_safe_user/elements/loader.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/infrastructure/services/sos_services.dart';
import 'package:stay_safe_user/presentation/safety_app_view/person_tracking/person_tracking_view.dart';

import '../../../../configurations/color_constants.dart';
import '../../../../configurations/res.dart';
import '../../../../elements/custom_icon_button.dart';
import '../../../../elements/custom_text.dart';
import '../../../../elements/sizes.dart';
import '../../../../infrastructure/models/notification_super_model.dart';

class NotificationViewBody extends StatefulWidget {
   NotificationViewBody({super.key});

  

  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {
  NotificationSuperModel notificationModel = NotificationSuperModel();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      notificationModel = await SosServices().getAndFetchAllNotificatiions();
      setState(() {
       isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Loader():   ListView.builder(
      itemCount: notificationModel.allNotificaitons.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              NavigationHelper.pushRoute(context, PersonTrackingView.routeName , notificationModel.listOfUsers[index].userId!);
            },
            splashColor: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     CircleAvatar(
                      backgroundImage: NetworkImage(notificationModel.listOfUsers[index].imageUrl),
                      radius: 36,
                    ),
                    kw10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        k5,
                        CustomText(
                          text: notificationModel.listOfUsers[index].fullname!,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        k5,
                        Container(
                          width: 160,
                          child: CustomText(
                            text:
                                notificationModel.allNotificaitons[index].notificationMessage!,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomIconButton(
                      color: ColorConstants.kPrimaryColor,
                      icon: Icons.more_vert,
                      size: 30,
                      onPressed: () {},
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
