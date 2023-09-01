import "dart:async";

import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:location/location.dart";
import "package:provider/provider.dart";
import "package:stay_safe_user/elements/loader.dart";
import "package:stay_safe_user/infrastructure/models/tracking_model.dart";

import "../../../../configurations/res.dart";
import "../../../../elements/custom_text.dart";
import "../../../../helper/custom_location.dart";
import "../../../../infrastructure/models/sos_alert.dart";
import "../../../../infrastructure/services/sos_services.dart";
import "../../../../infrastructure/services/tracking_services.dart";

class PersonTrackingViewBody extends StatefulWidget {
  final String recieverId;
  const PersonTrackingViewBody({super.key, required this.recieverId});

  @override
  State<PersonTrackingViewBody> createState() => _PersonTrackingViewBodyState();
}

class _PersonTrackingViewBodyState extends State<PersonTrackingViewBody> {
  LatLng? _currentLocation;
  bool isLoading = true;
  double zoom = 16;
  double radius = 60;
  BitmapDescriptor recieverMarkerIcon = BitmapDescriptor.defaultMarker;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    debugPrint(widget.recieverId);
    // Location().enableBackgroundMode(enable: true);
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      CustomLocation().getCoordinates().then((locationData) async {
        customMarkerIcon();
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
        ? const Loader()
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
                  : StreamProvider.value(
              initialData: TrackingModel(),
              value: TrackingServices()
                  .streamSpecificUserTracking(widget.recieverId),
              builder: (context, child) {
                TrackingModel trackingData = context.watch<TrackingModel>();
                LatLng reciverLocation =
                    LatLng(trackingData.lat ?? 0, trackingData.long ?? 0);
                return trackingData.trackerId == null
                    ? const Loader()
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
                        markers: {
                          Marker(
                            markerId: MarkerId(widget.recieverId),
                            position: reciverLocation,
                            icon: recieverMarkerIcon,
                          ),
                        },
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

  void customMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, Res.kUserMarkerIcon)
        .then(
      (icon) {
        recieverMarkerIcon = icon;
      },
    );
  }
}
