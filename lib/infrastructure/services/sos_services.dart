import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/helper/custom_location.dart';
import 'package:stay_safe_user/infrastructure/models/notification_model.dart';
import 'package:stay_safe_user/infrastructure/models/notification_super_model.dart';
import 'package:stay_safe_user/infrastructure/models/sos_alert.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';

import '../../configurations/api_key.dart';

class SosServices {
  Future<String> getCurrentAddress() async {
    String address = '';

    try {
      final coordinated = await CustomLocation().getCoordinates();
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinated.latitude},${coordinated.longitude}&key=${ApiKey.GOOOGLE_API_KEY}');

      await http
          .post(
        url,
      )
          .then((response) {
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;

        address =
            (decodedResponse['results'][5]['formatted_address']).toString();
      });
    } catch (err) {
      debugPrint("addresssssssss errrorrrrr" + err.toString());
    }

    return address;
  }

  Future<String?> sendAlertNotification(SosAlertModel sosAlertModel,
      [String? alertDocId]) async {
    String? alertId;
    try {
      alertId = alertDocId ?? Backend.kSosAlerts.doc().id;
      sosAlertModel.alertId = alertId;
      Backend.kSosAlerts.doc(alertId).set(sosAlertModel.toJson());
    } catch (err) {
      debugPrint(err.toString());
    }
    return alertId;
  }

  //get all alerts
  Future<List<SosAlertModel>> getAllAlerts() async {
    List<SosAlertModel> alertList = [];
    try {
      await Backend.kSosAlerts.get().then((value) {
        value.docs.forEach((element) {
          alertList.add(SosAlertModel.fromJson(element.data()));
        });
      });
    } catch (err) {
      debugPrint(err.toString());
    }
    return alertList;
  }

  //stream all alerts
  Stream<List<SosAlertModel>> streamAllAlerts() {
    return Backend.kSosAlerts.snapshots().map((event) {
      List<SosAlertModel> alertList = [];
      event.docs.forEach((element) {
        alertList.add(SosAlertModel.fromJson(element.data()));
      });
      return alertList;
    });
  }

  //send notification
  Future<void> sendingNotifications(
      NotificationsModel notificationsModel) async {
    try {
      final notificationId = Backend.kNotifications.doc().id;

      //setting notification Id
      notificationsModel.notificationId = notificationId;

      //sending notification
      await Backend.kNotifications
          .doc(notificationId)
          .set(notificationsModel.toJson());
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  //get notifications for specific user stream
  Future<NotificationSuperModel> getAndFetchAllNotificatiions() async {
    List<NotificationsModel> notificationsList = [];
    List<UserModel> _userList = [];

    NotificationSuperModel notificationSuperModel = NotificationSuperModel();
    try {
      await Backend.kNotifications
          .where("notificationRecievers", arrayContains: Backend.uid)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          notificationsList.add(NotificationsModel.fromJson(element.data()));
        });
      });

      await Backend.kUsers.get().then((value) {
        value.docs.forEach((element) {
          _userList.add(UserModel.fromJson(element.data()));
        });
      });

      notificationSuperModel = NotificationSuperModel(
          allNotificaitons: notificationsList, listOfUsers: _userList);
    } catch (err) {
      debugPrint(err.toString());
    }
    return notificationSuperModel;
  }
}
