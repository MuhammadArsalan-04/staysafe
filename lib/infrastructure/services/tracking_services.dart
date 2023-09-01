import 'package:location/location.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/helper/custom_location.dart';
import 'package:stay_safe_user/infrastructure/models/tracking_model.dart';

class TrackingServices {
  //upload Tracking
  Future<void> addLocationForTracking([double? lat, double? long]) async {
    LocationData coordinates = await CustomLocation().getCoordinates();
    await Backend.kTracking.doc(Backend.uid).set(
        TrackingModel(trackerId: Backend.uid, lat: lat?? coordinates.latitude!, long: long ?? coordinates.longitude!).toJson());
  }

  //stream tracking
  Stream<TrackingModel> streamTracking() {
    return Backend.kTracking.doc(Backend.uid).snapshots().map((event) {
      return TrackingModel.fromJson(event.data() as Map<String, dynamic>);
    });
  }

  //track specific user stream
  Stream<TrackingModel> streamSpecificUserTracking(String userId) {
    return Backend.kTracking.doc(userId).snapshots().map((event) {
      return TrackingModel.fromJson(event.data() as Map<String, dynamic>);
    });
  }

}
