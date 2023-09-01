import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/configurations/res.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/elements/sizes.dart';
import 'package:stay_safe_user/presentation/auth_view/login_screen/login_screen_view.dart';

import '../../../../elements/custom_button.dart';
import '../../../../helper/navigation_helper.dart';

class OnBoardingViewBody extends StatelessWidget {
  OnBoardingViewBody({super.key});
  PageController _pageController = PageController();

  List<String> onBoardingAssets = [
    Res.konBoarding1,
    Res.konBoarding2,
    Res.konBoarding3,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Res.kLogo,
            height: 100,
            width: 100,
            color: ColorConstants.kPrimaryColor,
          ),
          k30,
          Expanded(
            flex: 2,
            child: PageView.builder(
              controller: _pageController,
              itemCount: onBoardingAssets.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(
                      child: SvgPicture.asset(
                        onBoardingAssets[index],
                        height: 280,
                        width: double.infinity,
                      ),
                    ),
                    k15,
                    CustomText(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ac pulvinar dui. Donec mauris eros, dignissim eget ipsum vel, molestie volutpat lacus. Quisque porta dolor eget lacinia fringilla. Etiam gravida suscipit magna, sollicitudin maximus odio euismod in. Proin facilisis arcu at libero hendrerit, a egestas purus dapibus. Donec metus lorem, dapibus at aliquam a, vulputate non turpis. Duis suscipit augue quis diam pharetra rhoncus.',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.kgreyColor,
                    ),
                  ],
                );
              },
            ),
          ),
          k15,
          SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: const WormEffect(
              dotColor: ColorConstants.kInActiveIndicatorColor,
              activeDotColor: ColorConstants.kPrimaryColor,
              dotHeight: 14,
              dotWidth: 14,
              type: WormType.normal,
            ),
          ),
          k20,
          CustomButton(
            buttonText: 'Next',
            onTapped: () {
              _pageController.page == 2
                  ? NavigationHelper.removeAllRoutes(
                      context, LoginScreenView.routeName)
                  : _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn,
                    );
            },
            radius: 12,
          ),
          k10,
        ],
      ),
    );
  }
}

/*


 */
