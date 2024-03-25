import 'dart:math' as math;
import 'package:daamn/constant/exports.dart';

getSubString({required String txt, required int lenght}) {
  if (txt.length > lenght) {
    return "${txt.substring(0, lenght)}..";
  } else {
    return "$txt..";
  }
}

String extractFirstName(String fullName) {
  List<String> names = fullName.split(' ');
  if (names.isNotEmpty) {
    return names.first;
  }
  return '';
}

int sumOfNumericValues(String string1, String string2) {
  int sum = 0;

  // Regular expression to extract numeric values
  RegExp regExp = RegExp(r'\d+');

  // Extract numeric values from the first string
  Iterable<Match> matches1 = regExp.allMatches(string1);
  for (Match match in matches1) {
    sum += int.parse(match.group(0)!);
  }

  // Extract numeric values from the second string
  Iterable<Match> matches2 = regExp.allMatches(string2);
  for (Match match in matches2) {
    sum += int.parse(match.group(0)!);
  }
  print('Sum of numeric values: $sum');
  return sum;
}

String getTimeDifferenceString(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
  } else {
    return 'just now';
  }
}

List<Offset> friendPositions = [];

Offset calculatePosition(double currentUserLat, double currentUserLon,
    double friendLat, double friendLon, int index) {
  double distance =
      calculateDistance(currentUserLat, currentUserLon, friendLat, friendLon);
  double angle =
      math.atan2(friendLon - currentUserLon, friendLat - currentUserLat);

  // Convert angle to degrees
  double degrees = angle * 180 / math.pi;

  // Adjust degrees to be between 0 and 360
  if (degrees < 0) {
    degrees += 360;
  }

  // Calculate position on the screen based on angle and distance
  double radius = 100; // Distance from center of the screen
  double centerX = 200; // X coordinate of the center of the screen
  double centerY = 200; // Y coordinate of the center of the screen
  double positionX = centerX + radius * math.cos(math.pi / 180 * degrees);
  double positionY = centerY + radius * math.sin(math.pi / 180 * degrees);

  // Adjust position to avoid overlap
  Offset newPosition = Offset(positionX, positionY);
  for (int i = 0; i < friendPositions.length; i++) {
    if (i != index) {
      double dx = newPosition.dx - friendPositions[i].dx;
      double dy = newPosition.dy - friendPositions[i].dy;
      double distanceSquared = dx * dx + dy * dy;
      if (distanceSquared < 2500) {
        // Adjust this value as needed for your app
        // Overlapping, adjust the position
        double newAngle =
            (angle + 90 * (1)) % 360; // Adjust angle by 90 degrees
        newPosition = Offset(
          centerX + radius * math.cos(math.pi / 180 * newAngle),
          centerY + radius * math.sin(math.pi / 180 * newAngle),
        );
        break; // No need to check further
      }
    }
  }

  // Update the list of friend positions
  if (index >= friendPositions.length) {
    friendPositions.add(newPosition);
  } else {
    friendPositions[index] = newPosition;
  }

  return newPosition;
}

// calculateDistancee(
//     double myLat, double myLng, double otherLat, double otherLng) async {
//   double distanceInMeters =
//       Geolocator.distanceBetween(myLat, myLng, otherLat, otherLng);
//   double distanceInKm = distanceInMeters; // Convert meters to kilometers
//   return distanceInKm;
// }

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371.0; // in kilometers

  double dLat = math.pi / 180 * (lat2 - lat1);
  double dLon = math.pi / 180 * (lon2 - lon1);

  double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(math.pi / 180 * lat1) *
          math.cos(math.pi / 180 * lat2) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  double distance = earthRadius * c;
  return distance;
}
