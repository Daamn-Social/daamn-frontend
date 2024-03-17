// ignore: file_names
import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int pageIndex = 1;

  void updatePageIndex({required int value}) {
    pageIndex = value;
    notifyListeners();
  }
}
