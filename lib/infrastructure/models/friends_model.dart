// To parse this JSON data, do
//
//     final friendModel = friendModelFromJson(jsonString);

import 'dart:convert';

FriendModel friendModelFromJson(String str) => FriendModel.fromJson(json.decode(str));

String friendModelToJson(FriendModel data) => json.encode(data.toJson());

class FriendModel {
    String id;
    String friendId;

    FriendModel({
        required this.id,
        required this.friendId,
    });

    factory FriendModel.fromJson(Map<String, dynamic> json) => FriendModel(
        id: json["id"],
        friendId: json["friendId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "friendId": friendId,
    };
}
