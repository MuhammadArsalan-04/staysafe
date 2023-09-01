import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/configurations/res.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/elements/image_container.dart';
import 'package:stay_safe_user/elements/loader.dart';
import 'package:stay_safe_user/elements/sizes.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';
import 'package:stay_safe_user/infrastructure/providers/user_details_provider.dart';
import 'package:stay_safe_user/presentation/auth_view/login_screen/login_screen_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/custom_report_screen/custom_report_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/notification_screen/notification_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/profie_screen/layout/widget/card_profile_widgets.dart';
import 'package:stay_safe_user/presentation/safety_app_view/profie_screen/layout/widget/single_profile_widget.dart';
import 'package:stay_safe_user/presentation/safety_app_view/profile_details_screen/profile_details_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/trusted_members_screen/trusted_members_view.dart';

import '../../../../infrastructure/providers/username_provider.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  bool isSwitchOn = false;
  UserModel? model;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
      Duration.zero,
    ).then((_) async {
      final ref = Provider.of<UserDetailsProvider>(context, listen: false);
      await ref.getAndFetchUserDetails();

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   model = Provider.of<UserDetailsProvider>(context).getUserDetails;
    return isLoading
        ? const Center(
            child: Loader(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        
                        ImageContainer(
                            imageUrl: model!.imageUrl,
                            height: 100,
                            width: 100,
                            radius: 100,),
                        k10,
                        CustomText(
                          text: model!.fullname!,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        k5,
                        InkWell(
                          splashColor: ColorConstants.kgreyColor,
                          onTap: () {
                            NavigationHelper.pushRoute(
                                context, ProfileDetailsView.routeName);
                          },
                          child: CustomText(
                            text: 'edit profile',
                            fontSize: 14,
                            color: ColorConstants.kPrimaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        k15,
                        CardProfileWidget(
                          widgetsList: [
                            SingleProfileWidget(
                              text: 'Profile',
                              icon: Icons.person_pin_outlined,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              iconSize: 26,
                              iconColor: ColorConstants.kPrimaryColor,
                              textColor: ColorConstants.kPrimaryColor,
                              onTap: () {
                                NavigationHelper.pushRoute(
                                    context, ProfileDetailsView.routeName);
                              },
                            ),
                            SingleProfileWidget(
                              text: 'Trusted Members',
                              iconPath: Res.kTrustedMemberOut,
                              isImageIcon: true,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              iconColor: ColorConstants.kPrimaryColor,
                              iconSize: 26,
                              textColor: ColorConstants.kPrimaryColor,
                              onTap: () {
                                NavigationHelper.pushRoute(
                                    context, TrustedMembersView.routeName);
                              },
                            ),
                            SingleProfileWidget(
                              text: 'Crime report',
                              iconPath: Res.kCrimeReportOut,
                              isImageIcon: true,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              iconColor: ColorConstants.kPrimaryColor,
                              textColor: ColorConstants.kPrimaryColor,
                              iconSize: 26,
                              onTap: () {
                                NavigationHelper.pushRoute(
                                    context, CustomReportView.routeName);
                              },
                            ),
                          ],
                        ),
                        CardProfileWidget(
                          widgetsList: [
                            SingleProfileWidget(
                              text: 'Speech',
                              icon: Icons.mic_none,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              iconColor: ColorConstants.kPrimaryColor,
                              textColor: ColorConstants.kPrimaryColor,
                              iconSize: 26,
                              suffix: CupertinoSwitch(
                                activeColor: ColorConstants.kPrimaryColor,
                                value: isSwitchOn,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitchOn = value;
                                  });
                                },
                              ),
                            ),
                            SingleProfileWidget(
                              text: 'Notifications',
                              icon: Icons.notifications_outlined,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              iconColor: ColorConstants.kPrimaryColor,
                              textColor: ColorConstants.kPrimaryColor,
                              iconSize: 26,
                              onTap: () {
                                NavigationHelper.pushRoute(
                                    context, NotificationView.routeName);
                              },
                            ),
                          ],
                        ),
                        CardProfileWidget(
                          widgetsList: [
                            SingleProfileWidget(
                              text: 'Send us a message',
                              icon: Icons.message_outlined,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              iconColor: ColorConstants.kPrimaryColor,
                              textColor: ColorConstants.kPrimaryColor,
                              iconSize: 26,
                              onTap: () {},
                            ),
                            SingleProfileWidget(
                              text: 'About us',
                              icon: Icons.info_outline,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              iconColor: ColorConstants.kPrimaryColor,
                              textColor: ColorConstants.kPrimaryColor,
                              iconSize: 26,
                              onTap: () {},
                            ),
                          ],
                        ),
                        CardProfileWidget(
                          widgetsList: [
                            SingleProfileWidget(
                              text: 'Logout',
                              icon: Icons.logout_outlined,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              iconColor: ColorConstants.kPrimaryColor,
                              textColor: ColorConstants.kPrimaryColor,
                              iconSize: 26,
                              onTap: () {
                                Provider.of<UserDetailsProvider>(context,listen: false).logout(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
