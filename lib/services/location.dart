import 'package:geolocator/geolocator.dart';

getLocation() async {
  getLocationPermission();
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

isGpsEnabled() async {
  return await Geolocator.isLocationServiceEnabled();
}

getLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
}
