import 'package:flutter/material.dart';
import 'package:stay_safe_user/presentation/safety_app_view/splash_screen/layout/body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splashscreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreenBody(),
    );
  }
}