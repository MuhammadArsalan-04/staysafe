import 'package:flutter/material.dart';
import 'package:stay_safe_user/elements/loading_overlay.dart';
import 'package:stay_safe_user/presentation/auth_view/sign_up_screen/layout/body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const String routeName = '/signUp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(child: SafeArea(child: SignUpViewBody())),
    );
  }
}
