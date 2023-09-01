import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/elements/custom_text.dart';

class CustomAddMemberTabBar extends StatelessWidget {
  const CustomAddMemberTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: false,
        indicatorColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey,
        labelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: 16,
            ),
        labelColor: ColorConstants.kPrimaryColor,
        unselectedLabelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: 16,
            ),
        indicatorSize: TabBarIndicatorSize.tab,
        physics: const BouncingScrollPhysics(),
        labelPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        tabs: [
          Container(
            width: double.infinity,
            child: CustomText(
              textAlign: TextAlign.center,
              text: 'Add Members',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            width: double.infinity,
            child: CustomText(
              textAlign: TextAlign.center,
              text: 'Requests',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]);
  }
}
