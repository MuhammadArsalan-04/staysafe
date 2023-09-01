// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
    String? senderId;
    String? recieverId;
    String? messageId;
    String? message;
    String? messageType;
    Timestamp? messageTime;
    double? lat;
    double? long;

    MessageModel({
         this.senderId,
         this.recieverId,
         this.messageId,
         this.message,
         this.messageType,
         this.messageTime,
         this.lat,
         this.long,
    });

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        senderId: json["senderId"],
        recieverId: json["recieverId"],
        messageId: json["messageId"],
        message: json["message"],
        messageType: json["messageType"],
        messageTime: json["messageTime"],
        lat: json["lat"]?.toDouble(),
        long: json["long"],
    );

    Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "recieverId": recieverId,
        "messageId": messageId,
        "message": message,
        "messageType": messageType,
        "messageTime": messageTime,
        "lat": lat,
        "long": long,
    };
}
