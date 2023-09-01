import 'package:flutter/material.dart';
import '/presentation/safety_app_view/onboarding_screen/layout/body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});
  static const routeName = '/onboarding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: OnBoardingViewBody()),
    );
  }
}
