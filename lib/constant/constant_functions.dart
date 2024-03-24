import 'dart:math';
import 'package:daamn/constant/exports.dart';

getSubString({required String txt, required int lenght}) {
  if (txt.length > lenght) {
    return "${txt.substring(0, lenght)}..";
  } else {
    return "$txt..";
  }
}

Random _random = Random();

double getRandomSize(double width) {
  double randomWidth1 = _random.nextDouble() * (width - 80);

  double randomWidth2 = _random.nextDouble() * (width - 80);

  return (randomWidth1 * randomWidth2) / randomWidth2;
}

getRandonheight(double height, int index, int lenght) {
  double h = height * ((1 / (lenght + 2))) * (index + 1);
  if (h > (height / 2) - 80 && h < (height / 2) + 80) {
    if (h > (height / 2) - 100) {
      return h + 80;
    } else {
      return h - 80;
    }
  } else if (h > height * 0.8) {
    return _random.nextDouble() * (height * 0.1);
  }
  return h;
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
