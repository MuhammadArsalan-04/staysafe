import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:stay_safe_user/presentation/safety_app_view/self_tracking_screen/layout/body.dart';

class SelfTrackingView extends StatelessWidget {
  const SelfTrackingView({super.key});
  static const routeName = '/selftracking';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: SelfTrackingViewBody()),
    );
  }
}
