// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
    String? notificationId;
    String? senderId;
    String? notificationMessage;
    Timestamp? notificationTime;
    List<String> notificationRecievers;
    double? lat;
    double? long;

    NotificationsModel({
         this.notificationId,
         this.senderId,
         this.notificationMessage,
         this.notificationTime,
         this.notificationRecievers = const [],
         this.lat,
         this.long,
    });

    factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        notificationId: json["notificationId"],
        senderId: json["senderId"],
        notificationMessage: json["notificationMessage"],
        notificationTime: json["notificationTime"],
        notificationRecievers: List<String>.from(json["notificationRecievers"].map((x) => x)),
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "notificationId": notificationId,
        "senderId": senderId,
        "notificationMessage": notificationMessage,
        "notificationTime": notificationTime,
        "notificationRecievers": List<dynamic>.from(notificationRecievers.map((x) => x)),
        "lat": lat,
        "long": long,
    };
}
