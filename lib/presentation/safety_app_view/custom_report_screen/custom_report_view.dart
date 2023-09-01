import 'package:flutter/material.dart';
import 'package:stay_safe_user/presentation/safety_app_view/custom_report_screen/layout/custom_report_view_body.dart';

import '../../../configurations/color_constants.dart';
import '../../../elements/custom_text.dart';

class CustomReportView extends StatelessWidget {
  const CustomReportView({super.key});

  static const String routeName = '/custom_report';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.kPrimaryColor,
        title: CustomText(
          text: 'Crime Report',
          fontWeight: FontWeight.w500,
          
        ),
      ),
      body:  SafeArea(child: CustomReportViewBody()),
    );
  }
}
