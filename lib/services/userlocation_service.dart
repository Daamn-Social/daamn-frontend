import 'package:daamn/constant/exports.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:daamn/models/user_location_model.dart';

Future<UserLocation?> getUserLocation() async {
  PermissionStatus permission = await Permission.location.status;

  if (permission.isDenied) {
    // Request location permission
    permission = await Permission.location.request();
  }

  if (permission.isPermanentlyDenied) {
    // If permission is permanently denied, show a dialog
    // ignore: use_build_context_synchronously
    snaki(msg: "Location permission has been permanently denied");
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Location Permission'),
    //       content: const Text(
    //           'Location permission has been permanently denied. Please enable it from the app settings.'),
    //       actions: <Widget>[
    //         TextButton(
    //           child: const Text('OK'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
  if (permission.isGranted) {
    // If permission is granted, get the location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get the address
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    String userAdreedd =
        "${place.locality} : ${place.subAdministrativeArea} , ${place.administrativeArea} ${place.country}";
    debugPrint(
        '******************************************************************');
    debugPrint(
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    debugPrint(
        'City: ${place.subAdministrativeArea}, Country: ${place.country}');
    debugPrint('Address : $userAdreedd');
    debugPrint(
        '******************************************************************');
    UserLocation x = UserLocation(
        lat: position.latitude,
        lng: position.longitude,
        city: place.locality,
        country: place.country,
        address: userAdreedd);

    return x;
  }
  return null;
}
