import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<Map<String, String>> handleLocationPermission() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Map<String, String> result = {
      'status': 'failed',
      'message': 'Location services are disabled. Please enable the services'
    };
    return result;
  }

  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Map<String, String> result = {
        'status': 'failed',
        'message': 'Location permissions are denied',
      };
      return result;
    }
  }

  Map<String, String> result = {
    'status': 'success',
    'message': 'Successfully get permissions',
  };
  return result;
}

Future<Map<String, String>> getAddressFromLatLng(Position position) async {
  try {
    List<Placemark> address =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = address[0];
    Map<String, String> result = {
      'status': 'success',
      'street': place.street!,
      'subLocality': place.subLocality!,
      'subAdministrativeArea': place.subAdministrativeArea!,
      'postalCode': place.postalCode!
    };
    return result;
  } catch (e) {
    Map<String, String> result = {
      'status': 'failed',
      'message': 'Something went wrong',
    };
    return result;
  }
}

Future<Map<String, String>> getCurrentPosition() async {
  try {
    final hasPermission = await handleLocationPermission();
    if (hasPermission['status'] == 'failed') {
      Map<String, String> result = {
        'status': 'failed',
        'message': 'Something went wrong'
      };
      return result;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Map<String, String> result = await getAddressFromLatLng(position);
    Map<String, String> latAndLang = {
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString(),
    };
    result.addAll(latAndLang);
    return result;
  } catch (e) {
    Map<String, String> result = {
      'status': 'failed',
      'message': 'Something went wrong',
    };
    return result;
  }
}
