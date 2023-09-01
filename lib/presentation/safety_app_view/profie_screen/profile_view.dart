import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/presentation/safety_app_view/profie_screen/layout/body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routeName = '/profile_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kPrimaryColor.withOpacity(0.04),
      body: const SafeArea(child: ProfileViewBody()),
    );
  }
}
