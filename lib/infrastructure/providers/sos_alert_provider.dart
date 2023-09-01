import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/helper/google_map.dart';
import 'package:stay_safe_user/infrastructure/models/notification_model.dart';
import 'package:stay_safe_user/infrastructure/models/sos_alert.dart';
import 'package:stay_safe_user/infrastructure/services/chat_services.dart';
import 'package:stay_safe_user/infrastructure/services/friends_request_services.dart';
import 'package:stay_safe_user/infrastructure/services/sos_services.dart';

class SosAlertProvider with ChangeNotifier {
  List<SosAlertModel> _alertList = [];

  List<SosAlertModel> get alertList => _alertList;

  Future<void> alertNotificaiton(SosAlertModel alertModel) async {
    try {
      // if(_alertList.isNotEmpty){

      // }else{

      // }
      // // if (_alertList.contains(alertModel.alertId)) {
      // //   await SosServices().sendAlertNotification(alertModel, alertModel.alertId).then((id) {
      // //   });
      // // }

      await SosServices()
          .sendAlertNotification(alertModel)
          .then((alertId) async {
        alertModel.alertId = alertId;
        _alertList.add(alertModel);

        //fetching all friends
        List<String> friendsList =
            await FriendRequestServices().getAllFriendId(Backend.uid);

        //creating notification model
        final NotificationsModel notificationsModel = NotificationsModel(
          lat: alertModel.lat,
          long: alertModel.long,
          notificationMessage:
              "Your Friend is in Danger, Quickly Track Him To Help Him",
          notificationTime: Timestamp.now(),
          senderId: Backend.uid,
          notificationRecievers: friendsList,
        );

        //sending notification
        await SosServices().sendingNotifications(notificationsModel);

        //getting static map url
        final mapUrl = GoogleMapHelperClass.getStaticMapUrl(alertModel.lat!, alertModel.long!);

        //sending notification to friends chat here
        friendsList.forEach((friend) {
          //check if chatList exist
          ChatServices().checkIfChecklistExist(Backend.uid, friend).then((id) {
            if (id != null) {
              //if chatList exist
              ChatServices().createOrFetchChatList(
                  Backend.uid, friend, "Alert Notification to track", id).then((chatListId) {
                    //send message to chatList
                     ChatServices().sendMessage(
                  chatListId, Backend.uid, friend, mapUrl, "alert" , alertModel.lat, alertModel.long,);
                  });
            } else {
              //if chatList does not exist
              ChatServices().createOrFetchChatList(
                  Backend.uid, friend, "Alert Notification to track").then((chatListId) {
                    //send message to chatList
                     ChatServices().sendMessage(
                  chatListId, Backend.uid, friend, mapUrl, "alert", alertModel.lat, alertModel.long,);
                  });
            }
          });
        });
      });
    } catch (err) {
      debugPrint(err.toString());
    }
    notifyListeners();
  }

  //get and fetch all alerts
  Future<void> getAllAlerts() async {
    try {
      await SosServices().getAllAlerts().then((value) {
        _alertList = value;
        notifyListeners();
      });
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
