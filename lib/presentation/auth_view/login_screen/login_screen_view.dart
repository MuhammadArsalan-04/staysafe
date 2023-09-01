import 'package:flutter/material.dart';
import 'package:stay_safe_user/elements/loading_overlay.dart';
import 'package:stay_safe_user/presentation/auth_view/login_screen/layout/body.dart';

class LoginScreenView extends StatelessWidget {
  const LoginScreenView({super.key});
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(child: SafeArea(child: LoginScreenViewBody())),
    );
  }
}
