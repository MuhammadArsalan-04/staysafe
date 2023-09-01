import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/helper/custom_location.dart';
import 'package:stay_safe_user/infrastructure/models/sos_alert.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';
import 'package:stay_safe_user/infrastructure/providers/user_details_provider.dart';
import 'package:stay_safe_user/infrastructure/services/sos_services.dart';
import 'package:stay_safe_user/infrastructure/services/tracking_services.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:ui' as ui;

class SelfTrackingViewBody extends StatefulWidget {
  const SelfTrackingViewBody({super.key});

  @override
  State<SelfTrackingViewBody> createState() => _SelfTrackingViewBodyState();
}

class _SelfTrackingViewBodyState extends State<SelfTrackingViewBody> {
  LatLng? _currentLocation;
  bool isLoading = true;
  double zoom = 16;
  double radius = 60;

  // BitmapDescriptor? currentLocationIcon;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    // Location().enableBackgroundMode(enable: true);
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      CustomLocation().getCoordinates().then((locationData) async {
        getAndUpdateOnLocationChanged(locationData);
        // await customIconMarker();
        setState(() {
          _currentLocation =
              LatLng(locationData.latitude!, locationData.longitude!);
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CustomText(text: "Loading Map"),
          )
        : StreamProvider.value(
            initialData: [SosAlertModel()],
            value: SosServices().streamAllAlerts(),
            builder: (context, child) {
              List<SosAlertModel> alertList =
                  context.watch<List<SosAlertModel>>();
              return alertList[0].alertId == null
                  ? Center(
                      child: CustomText(text: "Loading Map"),
                    )
                  : GoogleMap(
                      circles: alertList.isEmpty
                          ? const <Circle>{}
                          : Set.from(alertList.map(
                              (alert) => Circle(
                                circleId: CircleId(alert.alertId!),
                                center: LatLng(alert.lat!, alert.long!),
                                radius: radius,
                                fillColor: Colors.red,
                                strokeWidth: 3,
                                strokeColor:
                                    const Color.fromARGB(255, 127, 249, 131),
                              ),
                            )),
                      indoorViewEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: _currentLocation!,
                        zoom: zoom,
                      ),
                      mapType: MapType.normal,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      compassEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      mapToolbarEnabled: true,
                      onCameraMove: (position) {
                        zoom = position.zoom;
                      },
                    );
            },
          );
  }

  void getAndUpdateOnLocationChanged(LocationData coordinates) async {
    Location location = Location();

    _currentLocation = LatLng(coordinates.latitude!, coordinates.longitude!);

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLocation) {
      TrackingServices()
          .addLocationForTracking(newLocation.latitude, newLocation.longitude);

      _currentLocation = LatLng(newLocation.latitude!, newLocation.longitude!);
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: zoom,
            target: _currentLocation!,
          ),
        ),
      );
    });
    setState(() {});
  }

  // Future<void> customIconMarker() async {
  //   UserModel model =
  //       Provider.of<UserDetailsProvider>(context, listen: false).getUserDetails;
  //   final response = await http.get(Uri.parse(model.imageUrl));
  //   Uint8List imageBytes = response.bodyBytes;

  //   final codec = await ui.instantiateImageCodec(imageBytes);
  //   final frame = await codec.getNextFrame();
  //   final image = await frame.image.toByteData(format: ui.ImageByteFormat.png);
  //   currentLocationIcon =
  //       BitmapDescriptor.fromBytes(image!.buffer.asUint8List());

       
  // }
}
