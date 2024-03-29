import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff924BF4);

const Color appWhiteColor = Colors.white;
const Color appBlackColor = Colors.black;
const Color scafoldBg = Color(0xff4d477f);
const Color transparent = Colors.transparent;
Color dividerColor = const Color(0xffBE87FC).withOpacity(0.3);

class TxtFieldColors {
  static const Color borderColor = Colors.black;
  static const Color filColor = Colors.blue;
}

List<Color> differentColors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.teal,
  Colors.pink,
  Colors.cyan,
  Colors.amber,
  Colors.indigo,
  Colors.lime,
  Colors.brown,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.deepPurpleAccent,
  Colors.blueGrey,
  const Color(0xFF00FF00), // Custom color (Green)
  const Color(0xFF123456), // Custom color (Dark blue)
];

LinearGradient primaryGradiant = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff924BF4), Color(0xff400099)],
);
LinearGradient whiteGradiant = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [appWhiteColor, appWhiteColor.withOpacity(0.8)],
);
LinearGradient blackGradiant = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [appBlackColor, appBlackColor, primaryColor],
);

List<BoxShadow> customShadow = [
  BoxShadow(
    color: primaryColor.withOpacity(0.4),
    spreadRadius: 4,
    blurRadius: 22,
    offset: const Offset(0, 3), // changes position of shadow
  ),
];
List<BoxShadow> customShadow2 = [
  BoxShadow(
    color: primaryColor.withOpacity(0.4),
    spreadRadius: 20,
    blurRadius: 220,
    offset: const Offset(0, 3), // changes position of shadow
  ),
];
