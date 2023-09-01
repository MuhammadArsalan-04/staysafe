// To parse this JSON data, do
//
//     final chatListModel = chatListModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ChatListModel chatListModelFromJson(String str) =>
    ChatListModel.fromJson(json.decode(str));

String chatListModelToJson(ChatListModel data) => json.encode(data.toJson());

class ChatListModel {
  ChatListModel({
    required this.chatListId,
    required this.senderid,
    required this.recieverid,
    required this.lastmessage,
    required this.lastMessageTime,
  });

  String? chatListId;
  String? senderid;
  String? recieverid;
  String? lastmessage;
  Timestamp? lastMessageTime;

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        chatListId: json["chatListId"],
        senderid: json["senderid"],
        recieverid: json["recieverid"],
        lastmessage: json["lastmessage"],
        lastMessageTime: json["lastMessageTime"],
      );

  Map<String, dynamic> toJson() => {
        "chatListId": chatListId,
        "senderid": senderid,
        "recieverid": recieverid,
        "lastmessage": lastmessage,
        "lastMessageTime": lastMessageTime,
      };
}
