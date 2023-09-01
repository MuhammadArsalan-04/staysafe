import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/configurations/res.dart';
import 'package:stay_safe_user/elements/custom_button.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/elements/sizes.dart';
import 'package:stay_safe_user/helper/google_map.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/infrastructure/providers/user_details_provider.dart';
import 'package:stay_safe_user/infrastructure/services/tracking_services.dart';
import 'package:stay_safe_user/presentation/safety_app_view/add_members_screen/add_members_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/custom_report_screen/custom_report_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/home_screen/layout/widget/activity_button_widget.dart';
import 'package:stay_safe_user/presentation/safety_app_view/home_screen/layout/widget/user_details_widget_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/self_tracking_screen/self_tracking_screen.dart';
import 'package:stay_safe_user/presentation/safety_app_view/sos_screen/sos_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/trusted_members_screen/trusted_members_view.dart';
import 'package:stay_safe_user/skeleton_loaders/profile_loader_widget.dart';

import '../../../../helper/custom_location.dart';

class HomeViewBody extends StatefulWidget {
  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  LocationData? _locationData;
  LatLng? _currentLocation;
  bool isInit = false;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      await Provider.of<UserDetailsProvider>(context, listen: false)
          .getAndFetchUserDetails();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!isInit) {
      Future.delayed(Duration.zero, () async {
        _locationData = await CustomLocation().getLocation();
        if (_locationData == null) {
          return;
        }
        updateLocation(_locationData!);
        TrackingServices().addLocationForTracking();
        setState(() {});
        isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDetails =
        Provider.of<UserDetailsProvider>(context).getUserDetails;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading
                ? const ProfileLoaderWidget()
                : UserDetailsWidgetView(
                    imageUrl: userDetails.imageUrl,
                    userName: userDetails.fullname,
                  ),
            k20,
            GestureDetector(
              onTap: () {
                NavigationHelper.pushRoute(context, AddMembersView.routeName);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ColorConstants.kgreyColor,
                    width: 1,
                  ),
                ),
                child: CustomText(
                  text: 'Search...',
                  fontSize: 16,
                  color: ColorConstants.kgreyColor,
                ),
              ),
            ),
            k20,
            CustomText(
              text: 'Current Location',
              fontWeight: FontWeight.bold,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: _locationData == null
                    ? Container()
                    : Image.network(
                        GoogleMapHelperClass.getStaticMapUrl(
                            _locationData!.latitude!,
                            _locationData!.longitude!),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Center(
              child: CustomButton(
                buttonText: 'Start Tracking',
                radius: 12,
                onTapped: () {
                  NavigationHelper.pushRoute(
                      context, SelfTrackingView.routeName);
                },
                width: 200,
              ),
            ),
            k25,
            AnimationList(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              duration: 3000,
              children: [
                InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    NavigationHelper.pushRoute(
                        context, AddMembersView.routeName);
                  },
                  child: ActivityButtonWidget(
                      text: 'Add Members', image: Res.kAddFriend),
                ),
                k10,
                InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      NavigationHelper.pushRoute(context, SOSView.routeName);
                    },
                    child: ActivityButtonWidget(text: 'SoS', image: Res.kSoS)),
                k10,
                InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    NavigationHelper.pushRoute(
                        context, TrustedMembersView.routeName);
                  },
                  child: ActivityButtonWidget(
                      text: 'Trusted Members', image: Res.kTrustedMember),
                ),
                k10,
                InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    NavigationHelper.pushRoute(
                        context, CustomReportView.routeName);
                  },
                  child: ActivityButtonWidget(
                      text: 'Crime Report', image: Res.kCrimeReport),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //iff any issue arrives remove this lines of code

  void updateLocation(LocationData coordinates) async {
    Location location = Location();
    location.enableBackgroundMode(enable: true);

    location.onLocationChanged.listen((newLocation) {
      TrackingServices()
          .addLocationForTracking(newLocation.latitude, newLocation.longitude);
    });
  }
}
