import '../configurations/api_key.dart';

class GoogleMapHelperClass {
  static String getStaticMapUrl(double latitude, double longitude) {
    print(latitude + longitude);
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=400x400&markers=color:red%7C$latitude,$longitude&key=${ApiKey.GOOOGLE_API_KEY}';
  }
}
