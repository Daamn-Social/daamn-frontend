import 'package:flutter/material.dart';
import 'package:daamn/constant/app_colors.dart';
import 'package:daamn/constant/global_context_key.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snaki(
    {required String msg}) {
  return scaffoldMessengerKey.currentState!.showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1200),
      backgroundColor: primaryColor,
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
