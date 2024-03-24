import 'package:daamn/constant/exports.dart';
import 'package:geolocator/geolocator.dart';

class NearByUserProvider extends ChangeNotifier {
  List<UserModel>? nearByUser;
  getUser({required double userLat, required double userLng}) async {
    nearByUser = await getUsersNearby(userLat, userLng);
    notifyListeners();
  }
}

Future<List<UserModel>> getUsersNearby(double userLat, double userLng) async {
  List<UserModel> nearbyUsers = [];
  double maxDistance = 100.0; // Maximum distance in meters

  // Get the current user's ID
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  // Get all users from Firebase
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();

  // Iterate over each user
  for (QueryDocumentSnapshot userSnapshot in querySnapshot.docs) {
    if (userSnapshot.id == currentUserId) continue;

    // Calculate distance between the current user and the user in the snapshot
    double distance = await calculateDistancee(
      userLat,
      userLng,
      userSnapshot['lat'],
      userSnapshot['lng'],
    );

    debugPrint(userSnapshot['name'] + " distance is : " + distance.toString());
    // If the distance is less than 10km, add the user to the nearbyUsers list
    if (distance <= maxDistance) {
      if (userSnapshot['online_Status'] == "Online") {
        nearbyUsers.add(
            UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>));
      }
    }
  }

  return nearbyUsers;
}

Future<double> calculateDistancee(
    double myLat, double myLng, double otherLat, double otherLng) async {
  double distanceInMeters =
      Geolocator.distanceBetween(myLat, myLng, otherLat, otherLng);
  double distanceInKm = distanceInMeters; // Convert meters to kilometers
  return distanceInKm;
}
