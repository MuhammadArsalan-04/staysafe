import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stay_safe_user/configurations/res.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/presentation/auth_view/login_screen/login_screen_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/bottom_navigation_bar/bottom_navigation.dart';
import 'package:stay_safe_user/presentation/safety_app_view/onboarding_screen/onboarding_view.dart';

import '../../../../configurations/color_constants.dart';
import '../../../../singleton/firebase_auth_instance.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), screenNavigator);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        Res.kLogo,
        height: 160,
        width: 160,
        color: ColorConstants.kPrimaryColor,
      ),
    );
  }

  void screenNavigator() {
    User? user = FirebaseAuthInstance.firebaseAuthInstance.currentUser;

    if (user != null) {
      NavigationHelper.pushReplacementRoute(
          context, BottomNavigation.routeName);
    } else {
      NavigationHelper.pushReplacementRoute(context, LoginScreenView.routeName);
    }

    // NavigationHelper.pushReplacementRoute(context, OnBoardingView.routeName);
  }
}
