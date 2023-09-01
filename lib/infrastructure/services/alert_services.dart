import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/infrastructure/models/crime_report_model.dart';

class AlertServices {
  Future<void> addCustomCrime(CrimeReportModel model) async {
    try {
      final reportId = Backend.kCustomReport.doc().id;

      model.reportId = reportId;

      await Backend.kCustomReport.doc(reportId).set(model.toJson());
    } on FirebaseException catch (err) {
      debugPrint(err.toString());
      rethrow;
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
