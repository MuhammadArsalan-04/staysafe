// To parse this JSON data, do
//
//     final sosAlertModel = sosAlertModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

SosAlertModel sosAlertModelFromJson(String str) => SosAlertModel.fromJson(json.decode(str));

String sosAlertModelToJson(SosAlertModel data) => json.encode(data.toJson());

class SosAlertModel {
    String? alertId;
    String? senderId;
    double? lat;
    double? long;
    String? status;
    Timestamp? alertTime;

    SosAlertModel({
         this.alertId,
         this.senderId,
         this.lat,
         this.long,
         this.status,
         this.alertTime,
    });

    factory SosAlertModel.fromJson(Map<String, dynamic> json) => SosAlertModel(
        alertId: json["alertId"],
        senderId: json["senderId"],
        lat: json["lat"],
        long: json["long"],
        status: json["status"],
        alertTime: json["alertTime"],
    );

    Map<String, dynamic> toJson() => {
        "alertId": alertId,
        "senderId": senderId,
        "lat": lat,
        "long": long,
        "status": status,
        "alertTime": alertTime,
    };
}
