import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/presentation/safety_app_view/home_screen/layout/body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: HomeViewBody()),
     
    );
  }
}
