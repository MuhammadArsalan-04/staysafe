import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stay_safe_user/elements/app_logo.dart';
import 'package:stay_safe_user/elements/loading_overlay.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';
import 'package:stay_safe_user/infrastructure/services/user_services.dart';
import 'package:stay_safe_user/presentation/auth_view/login_screen/login_screen_view.dart';
import 'package:stay_safe_user/presentation/auth_view/sign_up_screen/layout/widget/username_field_widget.dart';

import '../../../../configurations/color_constants.dart';
import '../../../../elements/custom_button.dart';
import '../../../../elements/custom_text.dart';
import '../../../../elements/custom_text_button.dart';
import '../../../../elements/custom_textfield.dart';
import '../../../../elements/sizes.dart';

class SignUpViewBody extends StatefulWidget {
  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  TextEditingController _fullNameController = TextEditingController();

  TextEditingController _userNameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _confirmPasswordController = TextEditingController();

  final List<String> gender = [
    'Select',
    'Male',
    'Female',
    'Other',
  ];

  String selectedGender = 'Select';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoaderVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(),
              k20,
              CustomTextField(
                validator: (err) {
                  if (_fullNameController.text.isEmpty) {
                    return 'Please provide your fullname';
                  }
                },
                hintText: 'Fullname',
                controller: _fullNameController,
                prefixIcon: Icons.account_circle_outlined,
                labelText: 'Fullname',
              ),
              k20,
              UsernameFieldWidget(
                validator: (err) {
                  if (_userNameController.text.isEmpty) {
                    return 'Please provide a username';
                  }
                },
                hintText: 'Username',
                labelText: 'Username',
                controller: _userNameController,
                prefixIcon: Icons.person_outline,
              ),
              k20,
              CustomTextField(
                hintText: 'E-mail',
                validator: (_) {
                  if (_emailController.text.isEmpty) {
                    return 'Please provide your email';
                  }

                  if (!_emailController.text.contains('@') ||
                      !_emailController.text.endsWith('.com')) {
                    return 'Invalid email address provided';
                  }
                },
                labelText: 'email',
                controller: _emailController,
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),
              k20,
              CustomTextField(
                hintText: 'Phone number',
                labelText: 'Phone number',
                validator: (err) {
                  if (_phoneController.text.isEmpty) {
                    return 'Please provide your phone number';
                  }
                },
                controller: _phoneController,
                prefixIcon: Icons.call_outlined,
                textInputType: TextInputType.phone,
              ),
              k20,
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                width: double.infinity,
                height: 64,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstants.kPrimaryColor,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.man_outlined,
                      color: ColorConstants.kgreyColor,
                      size: 30,
                    ),
                    kw5,
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          scrollbarRadius: const Radius.circular(40),
                          scrollbarThickness: 6,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(-20, 0),
                          style: TextStyle(
                              fontSize: 20,
                              color: selectedGender == 'Select'
                                  ? ColorConstants.kgreyColor
                                  : Colors.black),
                          hint: Text(
                            'Select',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: gender
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: 140,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              k20,
              CustomTextField(
                hintText: 'Password',
                validator: (err) {
                  if (_passwordController.text.isEmpty) {
                    return err = 'please provide password';
                  }

                  if (_passwordController.text.length < 6) {
                    return err = 'password length cannot be less than 6';
                  }
                },
                labelText: 'Password',
                controller: _passwordController,
                prefixIcon: Icons.lock_outline,
                isSuffix: true,
                isObsecure: true,
              ),
              k20,
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                validator: (err) {
                  if (_confirmPasswordController.text.isEmpty) {
                    return 'please re-type your password';
                  }

                  if (_confirmPasswordController.text.length < 6) {
                    return err = 'password length cannot be less than 6';
                  }
                  if (_confirmPasswordController.text !=
                      _passwordController.text) {
                    return 'password not matched';
                  }
                },
                labelText: 'Confirm Password',
                prefixIcon: Icons.lock_outline,
                isSuffix: true,
                isObsecure: true,
              ),
              k20,
              CustomButton(
                buttonText: 'Sign Up',
                radius: 12,
                onTapped: () {
                  submitForm();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: 'Already have an account?'),
                  CustomTextButton(
                    buttonText: 'Login',
                    onPressed: () {
                      loginNavigator(context);
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

  void submitForm() async {
    if (!(formKey.currentState!.validate())) {
      return;
    }

    if (selectedGender == 'Select') {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: CustomText(
              text: 'Please Select Gender',
            ),
          ),
        );
    }

    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    //backend logic here
    UserModel userDetails = UserModel(
      createdOn: Timestamp.fromDate(DateTime.now()),
      email: _emailController.text,
      fullname: _fullNameController.text,
      gender: selectedGender,
      phone: _phoneController.text,
      username: _userNameController.text.toLowerCase(),
    );

    await UserServices()
        .registerUser(userDetails, _passwordController.text, context)
        .then((_) {
      if (_isLoaderVisible) {
        context.loaderOverlay.hide();
      }
    });
  }
}
