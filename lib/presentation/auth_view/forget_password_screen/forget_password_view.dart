import 'package:flutter/material.dart';
import 'package:stay_safe_user/elements/loading_overlay.dart';
import 'package:stay_safe_user/presentation/auth_view/forget_password_screen/layout/body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  
  static const String routeName = '/forgetpasssword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(child: SafeArea(child: ForgetPasswordViewBody())),
    );
  }
}