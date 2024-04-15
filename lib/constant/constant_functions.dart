import 'dart:math' as math;
import 'package:daamn/constant/exports.dart';
import 'package:url_launcher/url_launcher.dart';

final screenHieght =
    MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height;
final screenWidth =
    MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width;

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

void urlLauncherCustom(String myUrl) async {
  // Check if the URL starts with 'http' or 'https'
  if (!myUrl.startsWith('http://') && !myUrl.startsWith('https://')) {
    // If not, add 'https://' at the beginning
    myUrl = 'https://$myUrl';
  }

  final Uri _url = Uri.parse(myUrl);
  if (!await launchUrl(_url)) {
    snaki(msg: 'Could not launch $_url');
    throw Exception('Could not launch $_url');
  }
}

enum UserPosition {
  Up,
  Down,
  Left,
  Right,
  TopLeft,
  TopRight,
  BottomLeft,
  BottomRight,
}

UserPosition getUserPosition(
    double user1Lat, double user1Lon, double user2Lat, double user2Lon) {
  if (user1Lat == user2Lat && user1Lon == user2Lon) {
    return UserPosition.Up; // Same position
  }

  if (user1Lat < user2Lat) {
    if (user1Lon < user2Lon) {
      return UserPosition.TopRight;
    } else if (user1Lon > user2Lon) {
      return UserPosition.TopLeft;
    } else {
      return UserPosition.Up;
    }
  } else if (user1Lat > user2Lat) {
    if (user1Lon < user2Lon) {
      return UserPosition.BottomRight;
    } else if (user1Lon > user2Lon) {
      return UserPosition.BottomLeft;
    } else {
      return UserPosition.Down;
    }
  } else {
    if (user1Lon < user2Lon) {
      return UserPosition.Right;
    } else {
      return UserPosition.Left;
    }
  }
}

Offset getOffsetForUserPosition(UserPosition position, int number) {
  // print(number.toString() + position.toString());
  switch (position) {
    case UserPosition.Up:
      return Offset(
          (screenWidth * 0.42), (screenHieght * 0.3) + (number * -30));
    case UserPosition.Down:
      return Offset((screenWidth * 0.42), (screenHieght * 0.5) + (number * 30));
    case UserPosition.Left:
      return Offset(
          (screenWidth * 0.25) + (number * -30), (screenHieght * 0.4));
    case UserPosition.Right:
      return Offset((screenWidth * 0.6) + (number * 30), (screenHieght * 0.4));
    case UserPosition.TopLeft:
      return Offset((screenWidth * 0.3) + (number * -30),
          (screenHieght * 0.33) + (number * -30));
    case UserPosition.TopRight:
      return Offset((screenWidth * 0.53) + (number * 30),
          (screenHieght * 0.33) + (number * -30));
    case UserPosition.BottomLeft:
      return Offset((screenWidth * 0.3) + (number * -30),
          (screenHieght * 0.48) + (number * 30));
    case UserPosition.BottomRight:
      return Offset((screenWidth * 0.5) + (number * 30),
          (screenHieght * 0.48) + (number * 30));
    default:
      return Offset.zero; // Default to no offset
  }
}
