import 'package:flutter/material.dart';
import 'package:stay_safe_user/presentation/safety_app_view/person_tracking/layout/body.dart';

class PersonTrackingView extends StatelessWidget {
  const PersonTrackingView({super.key});

  static const routeName = '/person_tracking';

  @override
  Widget build(BuildContext context) {
    final recieverId = ModalRoute.of(context)!.settings.arguments as String;
    debugPrint("recieverId: $recieverId");
    return Scaffold(
      body:  SafeArea(
        child: PersonTrackingViewBody(recieverId : recieverId),
      ),
    );
  }
}