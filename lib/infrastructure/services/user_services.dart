import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/elements/error_dialogue.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';
import 'package:stay_safe_user/presentation/auth_view/login_screen/login_screen_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/bottom_navigation_bar/bottom_navigation.dart';

import 'package:path/path.dart' as absolutePath;
import 'package:stay_safe_user/singleton/firebase_instance.dart';

import '../../singleton/firebase_auth_instance.dart';

class UserServices {
  //creating user
  Future<void> registerUser(
      UserModel model, String password, BuildContext context) async {
    try {
      await FirebaseAuthInstance.firebaseAuthInstance
          .createUserWithEmailAndPassword(
              email: model.email!, password: password)
          .then((userCredentials) async {
        //added user id to the model
        model.userId = userCredentials.user!.uid;
        //saving username in a collection
        await Backend.kUsernames
            .doc(userCredentials.user!.uid)
            .set({"username": model.username!.toLowerCase()});

        model.username = model.username!.toLowerCase();
        //saving user data in users collection
        await Backend.kUsers.doc(userCredentials.user!.uid).set(model.toJson());
      }).then((_) => showAlertDialogue(
                  context,
                  "Registered Successfully",
                  Colors.green,
                  "Your Account Has Been Registered Successfully.", () {
                NavigationHelper.pushReplacementRoute(
                    context, LoginScreenView.routeName);
              }));
    } on FirebaseAuthException catch (ex) {
      String error = '';

      //error handling for creating user
      switch (ex.code) {
        case 'email-already-in-use':
          error = "Account with this email already exists";
          break;
        case 'invalid-email':
          error = "invalid email address provided";
          break;
        case 'operation-not-allowed':
          error = "The email Accounts Were Disabled or Removed";
          break;
        case "weak-password":
          error = ex.message!;
          break;
      }
      showAlertDialogue(
        context,
        "Registration Failed",
        Colors.red,
        ex.message!,
        () {
          Navigator.of(context).pop();
        },
      );
    } catch (err) {
      showAlertDialogue(
        context,
        "Registration Failed",
        Colors.red,
        "Something went wrong! please check your internet connection or try again later",
        () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  //
  Future<void> signInUser(
      String email, String password, BuildContext context) async {
    try {
      UserCredential user = await FirebaseAuthInstance.firebaseAuthInstance
          .signInWithEmailAndPassword(email: email, password: password);

      if (user != null && !user.user!.emailVerified) {
        user.user!.sendEmailVerification();
        // ignore: use_build_context_synchronously
        return showAlertDialogue(
          context,
          "Alert!",
          Colors.red,
          'An Email verificaiton link has sent to your email, Please verify your email',
          () {
            Navigator.of(context).pop();
            
          },
        );
      }

      Backend.uid = user.user!.uid;
      // ignore: use_build_context_synchronously
      NavigationHelper.pushReplacementRoute(
          context, BottomNavigation.routeName);
    } on FirebaseAuthException catch (authEx) {
      String errorMessage = '';
      if (authEx.code == 'user-not-found') {
        errorMessage = 'No User Found with this email and password';
      }
      if (authEx.code == 'invalid-email') {
        errorMessage = 'Invalid email or password provided';
      }
      if (authEx.code == 'wrong-password') {
        errorMessage = 'The password you entered was incorrect';
      }

      showAlertDialogue(context, "Alert", Colors.red,
          errorMessage == '' ? authEx.message! : errorMessage, () {
        Navigator.of(context).pop();
      });
    } catch (err) {
      showAlertDialogue(context, "Alert!", Colors.red,
          "Something went wrong! Please check your internet connection or try again later",
          () {
        Navigator.of(context).pop();
      });
    }
  }

  Future<void> sendPasswordResetLink(BuildContext context, String email) async {
    try {
      await FirebaseAuthInstance.firebaseAuthInstance
          .sendPasswordResetEmail(email: email)
          .then((_) => showAlertDialogue(context, "Alert!", Colors.red,
                  'An account password reset link was sent to your email', () {
                NavigationHelper.pushReplacementRoute(
                    context, LoginScreenView.routeName);
              }));
    } on FirebaseAuthException catch (authEx) {
      String errorMessage = '';
      if (authEx.code == 'user-not-found') {
        errorMessage = 'No User Found For The given email';
      }
      if (authEx.code == 'invalid-email') {
        errorMessage = 'invalid email provided';
      }
      showErrorDialog(context, message: errorMessage);
    } catch (err) {
      showAlertDialogue(context, "Alert!", Colors.red,
          "Something went wrong while sending reset link! Please check your internet connection or try again later",
          () {
        Navigator.of(context).pop();
      });
    }
  }

  //upload profile image

  Future<void> uploadProfileImage(
      BuildContext context, String imagePath) async {
    try {
      File imageFile = File(imagePath);
      String imageUrl;

      final path = absolutePath.basename(imageFile.path);

      final ref =
          FirebaseStorage.instance.ref('ProfileImages/${Backend.uid}/$path');

      await ref.putFile(imageFile);
      imageUrl = await ref.getDownloadURL();

      await Backend.kUsers.doc(Backend.uid).update({
        "imageUrl": imageUrl,
      });
    } catch (ex) {
      showAlertDialogue(context, "Alert!", Colors.red,
          "Something went wrong while uploading your photo please try again later or check your internet connection",
          () {
        Navigator.of(context).pop();
      });
    }
  }

  //fetching userDetails

  Future<UserModel> getUserDetails() async {
    DocumentSnapshot userDoc = await Backend.kUsers.doc(Backend.uid).get();
    return UserModel.fromJson(userDoc.data()! as Map<String, dynamic>);
  }

  //updating user details
  Future<void> updateUserDetails(UserModel model) async {
    try {
      await Backend.kUsers.doc(Backend.uid).update(model.toJson());
    } on FirebaseException catch (ex) {
      debugPrint(ex.message);
      throw ex.message!;
    } catch (err) {
      debugPrint(err.toString());
      throw err.toString();
    }
  }

  //get and fetch all users
  Future<List<UserModel>> getAllUsers(String id) async {
    List<UserModel> users = [];
    try {
      QuerySnapshot userDocs =
          await Backend.kUsers.where("userId", isNotEqualTo: id).get();
      userDocs.docs.forEach((userDoc) {
        users.add(UserModel.fromJson(userDoc.data()! as Map<String, dynamic>));
      });
      return users;
    } on FirebaseException catch (ex) {
      debugPrint(ex.message);
      throw ex.message!;
    } catch (err) {
      debugPrint(err.toString());
      throw err.toString();
    }
  }

  //get specific user
  Future<UserModel> getSpecificUser(String id) async {
    try {
      DocumentSnapshot userDoc = await Backend.kUsers.doc(id).get();
      return UserModel.fromJson(userDoc.data()! as Map<String, dynamic>);
    } on FirebaseException catch (ex) {
      debugPrint(ex.message);
      throw ex.message!;
    } catch (err) {
      debugPrint(err.toString());
      throw err.toString();
    }
  }

  //logout user
  Future<void> logoutUser(BuildContext context) async {
    try {
      await FirebaseAuthInstance.firebaseAuthInstance.signOut().whenComplete(
          () => NavigationHelper.removeAllRoutes(
              context, LoginScreenView.routeName));
    } on FirebaseException catch (ex) {
      debugPrint(ex.message);
      throw ex.message!;
    } catch (err) {
      debugPrint(err.toString());
      throw err.toString();
    }
  }
}
