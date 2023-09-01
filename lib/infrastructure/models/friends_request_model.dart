// To parse this JSON data, do
//
//     final friendRequestModel = friendRequestModelFromJson(jsonString);

import 'dart:convert';

FriendRequestModel friendRequestModelFromJson(String str) =>
    FriendRequestModel.fromJson(json.decode(str));

String friendRequestModelToJson(FriendRequestModel data) =>
    json.encode(data.toJson());

class FriendRequestModel {
  String? id;
  String requesterId;
  String requestRecieverId;
  bool isAccepted;
  bool isRejected;

  FriendRequestModel({
    required this.requesterId,
    required this.requestRecieverId,
    this.id,
    this.isAccepted = false,
    this.isRejected = false,
  });

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) =>
      FriendRequestModel(
        requesterId: json["RequesterId"],
        id: json["id"],
        requestRecieverId: json["RequestRecieverId"],
        isAccepted: json["isAccepted"],
        isRejected: json["isRejected"],
      );

  Map<String, dynamic> toJson() => {
        "RequesterId": requesterId,
        "id": id,
        "RequestRecieverId": requestRecieverId,
        "isAccepted": isAccepted,
        "isRejected": isRejected,
      };
}
