// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.fullname,
    this.userId,
    this.imageUrl =
        'https://firebasestorage.googleapis.com/v0/b/staysafe-11254.appspot.com/o/images%2Fplaceholder.png?alt=media&token=4dd5470c-9b2e-4270-9316-bdda45128c57',
    this.username,
    this.email,
    this.phone,
    this.gender,
    this.isAdmin = false,
    this.createdOn,
  });

  String? userId;
  String? fullname;
  String imageUrl;
  String? username;
  String? email;
  String? phone;
  String? gender;
  bool isAdmin;
  Timestamp? createdOn;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullname: json["fullname"],
        username: json["username"],
        imageUrl: json["imageUrl"],
        userId: json["userId"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        createdOn: json["createdOn"],
        isAdmin: json["isAdmin"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "username": username,
        "email": email,
        "phone": phone,
        "gender": gender,
        "imageUrl": imageUrl,
        "isAdmin": isAdmin,
        "createdOn": createdOn,
        "userId": userId,
      };
}
