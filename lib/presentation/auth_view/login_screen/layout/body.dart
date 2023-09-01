import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/configurations/res.dart';
import 'package:stay_safe_user/elements/app_logo.dart';
import 'package:stay_safe_user/elements/custom_button.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/elements/custom_text_button.dart';
import 'package:stay_safe_user/elements/custom_textfield.dart';
import 'package:stay_safe_user/elements/sizes.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/infrastructure/services/user_services.dart';
import 'package:stay_safe_user/presentation/auth_view/forget_password_screen/forget_password_view.dart';
import 'package:stay_safe_user/presentation/auth_view/sign_up_screen/sign_up_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/home_screen/home_view.dart';

import '../../../safety_app_view/bottom_navigation_bar/bottom_navigation.dart';

class LoginScreenViewBody extends StatefulWidget {
  @override
  State<LoginScreenViewBody> createState() => _LoginScreenViewBodyState();
}

class _LoginScreenViewBodyState extends State<LoginScreenViewBody> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  bool _isLoaderVisible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(),
              k10,
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                ),
                child: CustomText(text: 'Email'),
              ),
              k10,
              CustomTextField(
                controller: _emailController,
                validator: (_) {
                  if (_emailController.text.isEmpty) {
                    return 'Please enter your email';
                  }
                },
                hintText: 'Enter Your Email',
                prefixIcon: Icons.email_outlined,
                textInputType: TextInputType.emailAddress,
              ),
              k10,
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                ),
                child: CustomText(text: 'Password'),
              ),
              k10,
              CustomTextField(
                controller: _passwordController,
                validator: (_) {
                  if (_passwordController.text.isEmpty) {
                    return 'Please enter your password';
                  }
                },
                hintText: 'Password',
                isObsecure: true,
                isSuffix: true,
                prefixIcon: Icons.lock_outline,
              ),
              k5,
              Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(
                    buttonText: 'Forget password?',
                    textColor: ColorConstants.kPrimaryColor,
                    onPressed: () {
                      forgetPasswordNavigator(context);
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              CustomButton(
                buttonText: 'Login',
                radius: 12,
                onTapped: () async {
                  await login();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: 'I don’t have an account?'),
                  CustomTextButton(
                    buttonText: 'Register',
                    onPressed: () {
                      registerScreenNavigator(context);
                    },
                    textColor: ColorConstants.kPrimaryColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void registerScreenNavigator(BuildContext context) {
    NavigationHelper.pushReplacementRoute(context, SignUpView.routeName);
  }

  void forgetPasswordNavigator(BuildContext context) {
    NavigationHelper.pushReplacementRoute(
        context, ForgetPasswordView.routeName);
  }

  Future<void> login() async {
    if (!(formKey.currentState!.validate())) {
      return;
    }
    context.loaderOverlay.show();

    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });

    await UserServices()
        .signInUser(_emailController.text, _passwordController.text, context)
        .then((value) {
      if (_isLoaderVisible) {
        context.loaderOverlay.hide();
      }
    });
  }
}
