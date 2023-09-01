// To parse this JSON data, do
//
//     final crimeReportModel = crimeReportModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CrimeReportModel crimeReportModelFromJson(String str) => CrimeReportModel.fromJson(json.decode(str));

String crimeReportModelToJson(CrimeReportModel data) => json.encode(data.toJson());

class CrimeReportModel {
    String? reportId;
    String? userId;
    String? name;
    String? contactNo;
    Timestamp? incidentDateTime;
    double? lat;
    double? long;
    String? address;
    String? incidentDescription;

    CrimeReportModel({
         this.reportId,
         this.userId,
         this.name,
         this.contactNo,
         this.incidentDateTime,
         this.lat,
         this.long,
         this.address,
         this.incidentDescription,
    });

    factory CrimeReportModel.fromJson(Map<String, dynamic> json) => CrimeReportModel(
        reportId: json["reportId"],
        userId: json["userId"],
        name: json["name"],
        contactNo: json["contactNo"],
        incidentDateTime: json["incidentDateTime"],
        lat: json["lat"],
        long: json["long"],
        address: json["address"],
        incidentDescription: json["incidentDescription"],
    );

    Map<String, dynamic> toJson() => {
        "reportId": reportId,
        "userId": userId,
        "name": name,
        "contactNo": contactNo,
        "incidentDateTime": incidentDateTime,
        "lat": lat,
        "long": long,
        "address": address,
        "incidentDescription": incidentDescription,
    };
}
