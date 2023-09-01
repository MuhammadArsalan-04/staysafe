import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/presentation/safety_app_view/trusted_members_screen/layout/trusted_members_view_body.dart';

class TrustedMembersView extends StatelessWidget {
  const TrustedMembersView({super.key});

  static const String routeName = '/trusted_members';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.kPrimaryColor,
        title: CustomText(
          text: 'Trusted Members',
          fontWeight: FontWeight.w500,
        ),
      ),
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: TrustedMembersViewBody(),
      )),
    );
  }
}
