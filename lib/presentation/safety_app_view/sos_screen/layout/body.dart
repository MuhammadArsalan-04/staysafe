import 'dart:async';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/elements/loader.dart';
import 'package:stay_safe_user/elements/sizes.dart';
import 'package:stay_safe_user/elements/snackbar_message.dart';
import 'package:stay_safe_user/helper/custom_location.dart';
import 'package:stay_safe_user/infrastructure/services/sos_services.dart';
import 'package:stay_safe_user/presentation/safety_app_view/sos_screen/layout/widget/call_widget.dart';
import 'package:stay_safe_user/presentation/safety_app_view/sos_screen/layout/widget/sos_button_widget.dart';

class SOSViewBody extends StatefulWidget {
  const SOSViewBody({super.key});

  @override
  State<SOSViewBody> createState() => _SOSViewBodyState();
}

class _SOSViewBodyState extends State<SOSViewBody> {
  bool isOnline = false;
  String? location;
  LocationData? locationCoordinates;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () async {
      await SosServices().getCurrentAddress().then((address) {
        setState(() {
          location = address;
        });
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        showSnackBarMessage(context, "Connected to ${result.name}");

        isOnline = true;
      } else {
        showSnackBarMessage(context, "No Internet Connection");

        isOnline = false;
      }

      setState(() {
        isOnline;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      color: Colors.white,
      backdropColor: Colors.white70,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      backdropTapClosesPanel: true,
      isDraggable: true,
      backdropEnabled: true,
      maxHeight: MediaQuery.of(context).size.height * 0.6,
      minHeight: 160,
      defaultPanelState: PanelState.CLOSED,
      panel: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            k10,
            Container(
              height: 10,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            k30,
            const Divider(
              indent: 20,
              endIndent: 20,
              thickness: 2,
            ),
            k20,
            CallWidget(
              onTap: () async {
                await FlutterPhoneDirectCaller.callNumber("15");
              },
              imageIcon: Icons.shield_outlined,
              title: 'Police',
              subtitle: '15',
            ),
            CallWidget(
              onTap: () async {
                await FlutterPhoneDirectCaller.callNumber("115");
              },
              imageIcon: Icons.local_hospital_outlined,
              title: 'Edhi Center',
              subtitle: '115',
            ),
            CallWidget(
              onTap: () async {
                await FlutterPhoneDirectCaller.callNumber("911");
              },
              imageIcon: Icons.local_police_outlined,
              title: 'Army',
              subtitle: '911',
            ),
            CallWidget(
              onTap: () async {
                await FlutterPhoneDirectCaller.callNumber("1122");
              },
              imageIcon: Icons.contact_emergency_outlined,
              title: 'Rescue',
              subtitle: '1122',
            ),
            CallWidget(
              onTap: () async {
                await FlutterPhoneDirectCaller.callNumber("16");
              },
              imageIcon: Icons.local_fire_department_outlined,
              title: 'Fire Brigade',
              subtitle: '16',
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 2,
                    color: isOnline ? ColorConstants.kGreenColor : Colors.grey,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: isOnline
                              ? ColorConstants.kGreenColor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    kw10,
                    CustomText(
                      text: isOnline ? 'Online' : "Offline",
                      color:
                          isOnline ? ColorConstants.kGreenColor : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
            k25,
            CustomText(
              text: 'Current Location',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            k15,
            Container(
              // width: 170,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorConstants.kPrimaryColor),
              child: location == null
                  ? const Loader(
                      color: Colors.white,
                      size: 30,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 24,
                        ),
                        kw5,
                        CustomText(
                          text: location!,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ],
                    ),
            ),
            k25,
            SOSButton(
              isOnline: isOnline,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    connectivitySubscription.cancel();
  }
}
