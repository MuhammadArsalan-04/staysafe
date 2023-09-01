// To parse this JSON data, do
//
//     final trackingModel = trackingModelFromJson(jsonString);

import 'dart:convert';

TrackingModel trackingModelFromJson(String str) => TrackingModel.fromJson(json.decode(str));

String trackingModelToJson(TrackingModel data) => json.encode(data.toJson());

class TrackingModel {
    String? trackerId;
    double? lat;
    double? long;

    TrackingModel({
         this.trackerId,
         this.lat,
         this.long,
    });

    factory TrackingModel.fromJson(Map<String, dynamic> json) => TrackingModel(
        trackerId: json["trackerId"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "trackerId": trackerId,
        "lat": lat,
        "long": long,
    };
}
