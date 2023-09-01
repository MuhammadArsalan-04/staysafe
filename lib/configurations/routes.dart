import 'package:flutter/material.dart';

import 'package:stay_safe_user/presentation/auth_view/forget_password_screen/forget_password_view.dart';
import 'package:stay_safe_user/presentation/auth_view/login_screen/login_screen_view.dart';
import 'package:stay_safe_user/presentation/auth_view/sign_up_screen/sign_up_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/add_members_screen/add_members_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/chat_list_screen/chatl_list_screen.dart';
import 'package:stay_safe_user/presentation/safety_app_view/chat_screen/chat_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/custom_report_screen/custom_report_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/home_screen/home_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/notification_screen/notification_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/onboarding_screen/onboarding_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/person_tracking/person_tracking_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/profie_screen/profile_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/profile_details_screen/profile_details_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/self_tracking_screen/self_tracking_screen.dart';
import 'package:stay_safe_user/presentation/safety_app_view/sos_screen/sos_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/trusted_members_screen/trusted_members_view.dart';

import '../presentation/safety_app_view/bottom_navigation_bar/bottom_navigation.dart';
import '../presentation/safety_app_view/splash_screen/splash_screen.dart';


class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.routeName: (context) => const SplashScreen(),
    LoginScreenView.routeName: (context) => const LoginScreenView(),
    OnBoardingView.routeName: (context) => const OnBoardingView(),
    SignUpView.routeName: (context) => const SignUpView(),
    ForgetPasswordView.routeName: (context) => const ForgetPasswordView(),
    HomeView.routeName: (context) => const HomeView(),
    SOSView.routeName: (context) => const SOSView(),
    AddMembersView.routeName: (context) => const AddMembersView(),
    TrustedMembersView.routeName: (context) => const TrustedMembersView(),
    CustomReportView.routeName: (context) => const CustomReportView(),
    BottomNavigation.routeName: (context) => BottomNavigation(),
    NotificationView.routeName: (context) => const NotificationView(),
    ChatListView.routeName: (context) => const ChatListView(),
    ChatView.routeName: (context) => const ChatView(),
    ProfileView.routeName: (context) => const ProfileView(),
    ProfileDetailsView.routeName: (context) => const ProfileDetailsView(),
    SelfTrackingView.routeName: (context) => const SelfTrackingView(),
    PersonTrackingView.routeName: (context) => const PersonTrackingView(),
  };
}
