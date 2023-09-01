import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:location/location.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/elements/custom_button.dart';
import 'package:stay_safe_user/elements/sizes.dart';
import 'package:stay_safe_user/elements/snackbar_message.dart';
import 'package:stay_safe_user/helper/custom_location.dart';
import 'package:stay_safe_user/infrastructure/models/sos_alert.dart';
import 'package:stay_safe_user/infrastructure/providers/sos_alert_provider.dart';
import 'package:stay_safe_user/presentation/safety_app_view/sos_screen/layout/body.dart';

import '../../../../../elements/custom_text.dart';

class SOSButton extends StatefulWidget {
  bool isOnline;
  SOSButton(
      {super.key, required this.isOnline, });

  @override
  State<SOSButton> createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> {
  Color stateColor = Colors.green.shade500;

  int index = 0;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.delayed(Duration.zero).then((value) async {
  //     widget.locationCoordinates = await CustomLocation().getCoordinates();

  //     //bad practice but permissible
  //     // setState(() {

  //     // });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async{
              if (!widget.isOnline) {
                showSnackBarMessage(
                    context, "Please Check Your Internet Connection");
                return;
              }
              setState(() {
                if (index >= 0 && index < 2) {
                  index++;
                }

                if (index == 1) {
                  stateColor = const Color(0xffF4CA1F);
                }
                if (index == 2) {
                  stateColor = Colors.red;
                }
              });

              if (index != 0) {
                LocationData locationCoordinates = await CustomLocation().getCoordinates();
                final DateTime alertTime = DateTime.now().add(const Duration(
                  minutes: 1,
                ));

                if (index == 1) {

                
                final alertModel = SosAlertModel(
                    lat: locationCoordinates.latitude,
                    long: locationCoordinates.longitude,
                    senderId: Backend.uid,
                    alertTime: Timestamp.fromDate(alertTime),
                    status: "warning");
                SosAlertProvider().alertNotificaiton(alertModel);
              }

              if (index == 2) {
                final alertModel = SosAlertModel(
                    lat: locationCoordinates.latitude,
                    long: locationCoordinates.longitude,
                    senderId: Backend.uid,
                    alertTime: Timestamp.fromDate(alertTime),
                    status: "high_alert");
                SosAlertProvider().alertNotificaiton(alertModel);
              }
              }
              
            },
            child: Container(
              height: 210,
              width: 210,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(130),
                border: Border.all(
                  width: 7,
                  color: stateColor,
                ),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: 160,
                width: 160,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                    boxShadow: [
                      BoxShadow(
                        inset: index == 2,
                        color: const Color(0xFFBEBEBE),
                        offset: index == 2
                            ? const Offset(-1, -1)
                            : const Offset(-2, -2),
                        blurRadius: index == 1 ? 20 : 10,
                      ),
                      BoxShadow(
                        inset: index == 2,
                        color: const Color(0xFFBEBEBE),
                        offset: index == 2
                            ? const Offset(1, 1)
                            : const Offset(2, 2),
                        blurRadius: index == 2 ? 12 : 10,
                      ),
                    ]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 120,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                      boxShadow: [
                        BoxShadow(
                          inset: index == 1 || index == 2,
                          color: const Color(0xFFBEBEBE),
                          offset: index == 1 || index == 2
                              ? const Offset(-2, -2)
                              : const Offset(-1, -1),
                          blurRadius: index == 1 ? 20 : 15,
                        ),
                        BoxShadow(
                          inset: index == 1 || index == 2,
                          color: const Color(0xFFBEBEBE),
                          offset: index == 1 || index == 2
                              ? const Offset(2, 2)
                              : const Offset(1, 1),
                          blurRadius: index == 1 || index == 2 ? 12 : 15,
                        ),
                      ]),
                  child: CustomText(
                    text: 'SOS',
                    textAlign: TextAlign.center,
                    color: stateColor,
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          k20,
          ElevatedButton.icon(
            onPressed: index == 0
                ? null
                : () {
                    setState(() {
                      index = 0;
                      stateColor = Colors.green.shade500;
                    });
                  },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            label: CustomText(
              text: 'Reset',
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(30, 46)),
          ),
        ],
      ),
    );
  }
}
