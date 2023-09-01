import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:stay_safe_user/presentation/auth_view/forget_password_screen/forget_password_view.dart';
import 'package:stay_safe_user/presentation/auth_view/login_screen/login_screen_view.dart';
import 'package:stay_safe_user/presentation/auth_view/sign_up_screen/sign_up_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/chat_list_screen/chatl_list_screen.dart';
import 'package:stay_safe_user/presentation/safety_app_view/home_screen/home_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/profie_screen/profile_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/self_tracking_screen/self_tracking_screen.dart';

import '../../../elements/custom_text.dart';

class BottomNavigation extends StatefulWidget {
  static const routeName = '/bottom_navigationbar';
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List screenList = [
    const HomeView(),
    const SelfTrackingView(),
    const ChatListView(),

    const ProfileView()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        curve: Curves.easeIn,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.home_outlined,
              size: 28,
            ),
            title: CustomText(
              text: 'Home',
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.public_outlined,
              size: 28,
            ),
            title: CustomText(
              text: 'Map',
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.message_outlined,
              size: 28,
            ),
            title: CustomText(
              text: 'Chats',
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.person_pin_sharp,
              size: 28,
            ),
            title: CustomText(
              text: 'profile',
            ),
          ),
        ],
      ),
    );
  }
}
