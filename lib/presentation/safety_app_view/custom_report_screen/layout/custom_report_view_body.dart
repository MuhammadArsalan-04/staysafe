import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:location/location.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/elements/custom_button.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/elements/custom_textfield.dart';
import 'package:stay_safe_user/elements/error_dialogue.dart';
import 'package:stay_safe_user/elements/loading_overlay.dart';
import 'package:stay_safe_user/elements/sizes.dart';
import 'package:stay_safe_user/helper/custom_location.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/infrastructure/models/crime_report_model.dart';
import 'package:stay_safe_user/infrastructure/services/alert_services.dart';
import 'package:stay_safe_user/infrastructure/services/sos_services.dart';
import 'package:stay_safe_user/presentation/safety_app_view/bottom_navigation_bar/bottom_navigation.dart';
import 'package:stay_safe_user/presentation/safety_app_view/custom_report_screen/layout/widget/date_time_picker_widget.dart';
import 'package:stay_safe_user/presentation/safety_app_view/custom_report_screen/layout/widget/text_field_view.dart';

class CustomReportViewBody extends StatefulWidget {
  CustomReportViewBody({super.key});

  @override
  State<CustomReportViewBody> createState() => _CustomReportViewBodyState();
}

class _CustomReportViewBodyState extends State<CustomReportViewBody> {
  TextEditingController nameController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController incidentController = TextEditingController();

  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                k20,
                CustomText(
                  text: 'Your Information',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                k5,
                CustomText(
                  text: 'We will contact you soon',
                  color: ColorConstants.kgreyColor,
                  fontSize: 12,
                ),
                k30,
                CustomTextField(
                  hintText: 'Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                  },
                ),
                k10,
                CustomTextField(
                  hintText: 'Contact No',
                  controller: numberController,
                  textInputType: TextInputType.number,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    if (p0.length < 11 || p0.length > 11) {
                      return 'Please enter a valid contact number 11 digits';
                    }
                  },
                ),
                k30,
                CustomText(
                  text: 'Incident',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                k5,
                CustomText(
                  text:
                      'Describe the incident in truest and most accurate way as possible',
                  color: ColorConstants.kgreyColor,
                  softwrap: true,
                  fontSize: 12,
                ),
                k15,
                Row(
                  children: [
                    Expanded(
                      child: DateTimePickerWidget(
                          hintText: "Date",
                          dateTimePickerType: DateTimePickerType.dateTime,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please enter the date';
                            }
                          },
                          controller: dateController,
                          start: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day),
                          end: DateTime(DateTime.now().year + 1),
                          mask: 'MM/d/yyyy'),
                    ),
                    // kw10,
                    // Expanded(
                    //   child: DateTimePickerWidget(
                    //       hintText: "Time",
                    //       dateTimePickerType: DateTimePickerType.time,
                    //       controller: timeController,
                    //       validator: (p0) {
                    //         if (p0 == null || p0.isEmpty) {
                    //           return 'Please enter the time';
                    //         }
                    //       },
                    //       start: DateTime(DateTime.now().year,
                    //           DateTime.now().month, DateTime.now().day),
                    //       end: DateTime(DateTime.now().year + 1),
                    //       mask: 'MM/d/yyyy'),
                    // ),
                  ],
                ),
                k20,
                GoogleAutoCompleteFieldWidget(
                  isSuffix: true,
                  suffixIcon: Icons.my_location_rounded,
                  controller: locationController,
                  hintText: "Location",
                  iconSize: 30,
                  validator: (p0) {
                    if (p0.isEmpty) {
                      return 'Please enter the location';
                    }
                  },
                  onLocationTap: getAddressForCurrentCoordinates,
                ),
                k20,
                TextFieldView(
                  hintText: 'Incident Description',
                  controller: incidentController,
                  maxLines: 7,
                  validator: (p0) {
                    if (p0.isEmpty) {
                      return 'Please enter the incident description';
                    }
                  },
                ),
                k30,
                CustomButton(
                  buttonText: 'Report',
                  radius: 12,
                  onTapped: () async {
                    if (!(formKey.currentState!.validate())) {
                      return;
                    }

                    await uploadCrimeReport();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getAddressForCurrentCoordinates() async {
    context.loaderOverlay.show();

    setState(() {
      isLoading = context.loaderOverlay.visible;
    });

    await SosServices().getCurrentAddress().then((value) {
      locationController.text = value;
      if (isLoading) {
        context.loaderOverlay.hide();
      }
    });
    debugPrint(locationController.text);
  }

  Future<void> uploadCrimeReport() async {
    context.loaderOverlay.show();
    setState(() {
      isLoading = context.loaderOverlay.visible;
    });

    DateTime reportTime = DateTime.parse(dateController.text);
    final datetime = Timestamp.fromDate(reportTime);

    LocationData coordinates = await CustomLocation().getCoordinates();
    CrimeReportModel reportModel = CrimeReportModel(
      userId: Backend.uid,
      name: nameController.text,
      contactNo: numberController.text,
      incidentDateTime: datetime,
      lat: coordinates.latitude,
      long: coordinates.longitude,
      address: locationController.text,
      incidentDescription: incidentController.text,
    );

    try {
      await AlertServices().addCustomCrime(reportModel).then((value) {
        if (isLoading) {
          context.loaderOverlay.hide();
        }
        showAlertDialogue(context, "Succesful", ColorConstants.kGreenColor,
            "Your Report Has Been Submitted Successfully.\nThanks For Your Cooperation",
            () {
          Navigator.pop(context);
          NavigationHelper.removeAllRoutes(context, BottomNavigation.routeName);
        });
      });
    } catch (e) {
      debugPrint(e.toString());

      // ignore: use_build_context_synchronously
      showAlertDialogue(context, "Failed", Colors.red,
          "Something went wrong while uploading your report please try again later",
          () {
        Navigator.pop(context);
      });
    }
  }
}
