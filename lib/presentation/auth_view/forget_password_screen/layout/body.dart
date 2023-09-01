import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stay_safe_user/elements/app_logo.dart';
import 'package:stay_safe_user/elements/sizes.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/infrastructure/services/user_services.dart';
import 'package:stay_safe_user/presentation/auth_view/login_screen/login_screen_view.dart';
import 'package:stay_safe_user/presentation/auth_view/sign_up_screen/sign_up_view.dart';

import '../../../../configurations/color_constants.dart';
import '../../../../elements/custom_button.dart';
import '../../../../elements/custom_text.dart';
import '../../../../elements/custom_text_button.dart';
import '../../../../elements/custom_textfield.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  TextEditingController _emailController = TextEditingController();

  bool _isLoaderVisible = false;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(),
              k20,
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                ),
                child: CustomText(text: 'Email'),
              ),
              k10,
              CustomTextField(
                hintText: 'Enter your account email',
                validator: (_) {
                  if (_emailController.text.isEmpty) {
                    return 'Please enter your email';
                  }
                },
                controller: _emailController,
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),
              k10,
              const SizedBox(
                height: 210,
              ),
              CustomButton(
                buttonText: 'Send Link',
                radius: 12,
                onTapped: () async {
                  await sendResetLink();
                },
              ),
              k10,
              CustomButton(
                buttonText: 'Login',
                radius: 12,
                onTapped: () {
                  loginNavigator(context);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: 'I don’t have an account?'),
                  CustomTextButton(
                    buttonText: 'Register',
                    onPressed: () {
                      registerNavigator(context);
                    },
                    textColor: ColorConstants.kPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginNavigator(BuildContext context) {
    NavigationHelper.pushReplacementRoute(context, LoginScreenView.routeName);
  }

  void registerNavigator(BuildContext context) {
    NavigationHelper.pushReplacementRoute(context, SignUpView.routeName);
  }

  Future<void> sendResetLink() async {
    if (!(formkey.currentState!.validate())) {
      return;
    }
    context.loaderOverlay.show();

    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });

    await UserServices()
        .sendPasswordResetLink(context, _emailController.text)
        .then((_) {
      if (_isLoaderVisible) {
        context.loaderOverlay.hide();
      }
    });
  }
}
