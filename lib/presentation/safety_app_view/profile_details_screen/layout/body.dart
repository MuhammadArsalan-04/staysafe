import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/elements/custom_button.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/elements/image_container.dart';
import 'package:stay_safe_user/elements/loader.dart';
import 'package:stay_safe_user/elements/loading_overlay.dart';
import 'package:stay_safe_user/elements/sizes.dart';
import 'package:stay_safe_user/elements/snackbar_message.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';
import 'package:stay_safe_user/infrastructure/providers/user_details_provider.dart';
import 'package:stay_safe_user/infrastructure/services/user_services.dart';
import 'package:stay_safe_user/presentation/safety_app_view/profile_details_screen/layout/widget/profile_textfield.dart';

import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;

class ProfileDetailsViewBody extends StatefulWidget {
  const ProfileDetailsViewBody({super.key});

  @override
  State<ProfileDetailsViewBody> createState() => _ProfileDetailsViewBodyState();
}

class _ProfileDetailsViewBodyState extends State<ProfileDetailsViewBody> {
  File? _capturedImage;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();

  bool _isLoaderVisible = false;
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
  Widget build(BuildContext context) {
    final providerRef = Provider.of<UserDetailsProvider>(context);
    final details = providerRef.getUserDetails;

    _fullNameController.text =
        details.fullname == null ? '' : details.fullname!;
    _mobileNumberController.text = details.phone == null ? '' : details.phone!;
    return isLoading
        ? const Center(
            child: Loader(
              color: ColorConstants.kPrimaryColor,
            ),
          )
        : LoadingOverlay(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ImageContainer(
                                imageUrl: details.imageUrl,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 44,
                                width: 44,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: ColorConstants.kPrimaryColor),
                                child: IconButton(
                                  alignment: Alignment.center,
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    pickImage();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    k20,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 10.0,
                      ),
                      child: CustomText(
                        text: 'Fullname',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: ColorConstants.kPrimaryColor,
                      ),
                    ),
                    k10,
                    ProfileTextFieldWidget(
                      controller: _fullNameController,
                      readOnly: true,
                      showSuffix: true,
                      radius: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 10.0,
                      ),
                      child: CustomText(
                        text: 'username',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: ColorConstants.kPrimaryColor,
                      ),
                    ),
                    k10,
                    ProfileTextFieldWidget(
                      initialValue: details.username,
                      radius: 40,
                      readOnly: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 10.0,
                      ),
                      child: CustomText(
                        text: 'email',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: ColorConstants.kPrimaryColor,
                      ),
                    ),
                    k10,
                    ProfileTextFieldWidget(
                      initialValue: details.email,
                      radius: 40,
                      readOnly: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 10.0,
                      ),
                      child: CustomText(
                        text: 'Gender',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: ColorConstants.kPrimaryColor,
                      ),
                    ),
                    k10,
                    ProfileTextFieldWidget(
                      initialValue: details.gender,
                      radius: 40,
                      readOnly: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 10.0,
                      ),
                      child: CustomText(
                        text: 'Mobile number',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: ColorConstants.kPrimaryColor,
                      ),
                    ),
                    k10,
                    ProfileTextFieldWidget(
                      controller: _mobileNumberController,
                      textInputType: TextInputType.phone,
                      radius: 40,
                      readOnly: true,
                      showSuffix: true,
                    ),
                    k50,
                    k50,
                    CustomButton(
                      buttonText: 'Update',
                      radius: 12,
                      onTapped: () async {
                        if (_fullNameController.text.isEmpty ||
                            _mobileNumberController.text.isEmpty) {
                          showSnackBarMessage(
                              context,
                              _fullNameController.text.isEmpty
                                  ? "Please provide your fullname"
                                  : "Please Enter Your Mobile Number");
                          return;
                        }

                        if (_fullNameController.text == details.fullname &&
                            _mobileNumberController.text == details.phone) {
                          showSnackBarMessage(context, "No changes made");
                          return;
                        }

                        //updated user model
                        UserModel updatedModel = UserModel(
                          createdOn: details.createdOn,
                          email: details.email,
                          gender: details.gender,
                          imageUrl: details.imageUrl,
                          isAdmin: details.isAdmin,
                          username: details.username,
                          fullname: _fullNameController.text,
                          phone: _mobileNumberController.text,
                        );

                        await updatingUserDetails(providerRef, updatedModel);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void getCapturedImage(File capturedFile) async {
    context.loaderOverlay.show();

    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });

    await UserServices()
        .uploadProfileImage(context, capturedFile.path)
        .then((_) {
      if (_isLoaderVisible) {
        context.loaderOverlay.hide();
      }
    });
  }

  Future<void> pickImage() async {
    XFile? captureImage;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      captureImage = await ImagePicker()
                          .pickImage(source: ImageSource.camera);

                      getCapturedImage(File(captureImage!.path));
                    },
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      size: 50,
                    )),
                IconButton(
                  onPressed: () async {
                    captureImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    setPath(File(captureImage!.path));
                  },
                  icon: const Icon(
                    Icons.collections,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void setPath(File image) async {
    if (image.path.isEmpty) {
      return;
    }
    Directory appDirectory = await sysPath.getApplicationDocumentsDirectory();
    String fileName = path.basename(image.path);

    final File pickedImage = await image.copy("${appDirectory.path}/$fileName");

    getCapturedImage(pickedImage);
  }

  //updating profile
  Future<void> updatingUserDetails(
      UserDetailsProvider providerRef, UserModel updatedModel) async {
    context.loaderOverlay.show();

    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });

    await providerRef
        .updateAndFetchUserDetails(updatedModel)
        .then(
            (_) => showSnackBarMessage(context, "Profile updated successfully"))
        .then((value) {
      if (_isLoaderVisible) {
        context.loaderOverlay.hide();
      }
    });
  }
}
