import 'package:flutter/material.dart';
import 'package:stay_safe_user/presentation/safety_app_view/sos_screen/layout/body.dart';

class SOSView extends StatelessWidget {
  const SOSView({super.key});
  static const routeName = '/sos';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: SOSViewBody()),
    );
  }
}
