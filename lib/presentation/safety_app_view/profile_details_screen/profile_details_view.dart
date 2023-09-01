import 'package:flutter/material.dart';
import 'package:stay_safe_user/presentation/safety_app_view/profile_details_screen/layout/body.dart';

import '../../../configurations/color_constants.dart';
import '../../../elements/custom_text.dart';

class ProfileDetailsView extends StatelessWidget {
  const ProfileDetailsView({super.key});
  static const routeName = '/profile_details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorConstants.kPrimaryColor,
          title: CustomText(
            text: 'Profile',
            fontWeight: FontWeight.w500,
          ),
        ),
        body: const SafeArea(child: ProfileDetailsViewBody()));
  }
}
