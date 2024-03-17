import 'package:flutter/material.dart';

Widget verticalSpacer({required double space}) {
  return Builder(builder: (context) {
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h * space,
    );
  });
}

Widget horizontalSpacer({required double space}) {
  return Builder(builder: (context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w * space,
    );
  });
}
