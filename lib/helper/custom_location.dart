import 'package:flutter/material.dart';
import 'package:location/location.dart';

class CustomLocation {
  Location location = Location();

  Future<LocationData?> getLocation() async {
    bool _serviceEnabled;
PermissionStatus _permissionGranted;
LocationData? _locationData;

_serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  debugPrint(('Location services are $_serviceEnabled'));
  if (!_serviceEnabled) {
   _serviceEnabled = await location.requestService();
  }
}

_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  debugPrint(('Location services are $_permissionGranted'));
  if (_permissionGranted != PermissionStatus.granted) {
    _permissionGranted = await location.requestPermission();
  }
}

    if(_permissionGranted == PermissionStatus.granted && _serviceEnabled == true){
       _locationData = await location.getLocation();
    }
  
  return _locationData;
  }

  Future<bool> getServiceStatus() async {
    bool _serviceEnabled;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        if(_serviceEnabled == false)
        {
          debugPrint(('Location services are disabled.'));
        }

        if(_serviceEnabled == true){
          
        debugPrint(('Location services are enabled.'));
        }
        return _serviceEnabled;
      }
    }

    return _serviceEnabled;
  }

  Future<LocationData> getCoordinates() async {
    LocationData _locationData;
    _locationData = await location.getLocation();
    return _locationData;
  }
}
