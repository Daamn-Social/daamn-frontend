// ignore: file_names
import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int pageIndex = 1;

  void updatePageIndex({required int value}) {
    pageIndex = value;
    notifyListeners();
  }

  List<dynamic> userInterest = [];

  addinterest({required String txt}) {
    userInterest.add(txt);

    notifyListeners();
  }

  deleteinterest({required int index}) {
    userInterest.removeAt(index);

    notifyListeners();
  }

  assignInterest({List<dynamic>? listInteresr}) {
    if (listInteresr != null) {
      userInterest = listInteresr;
    }

    notifyListeners();
  }

  //
  List<dynamic> userimages = [];

  addimages({required String txt}) {
    userimages.add(txt);

    notifyListeners();
  }

  deleteimages({required int index}) {
    userimages.removeAt(index);
    notifyListeners();
  }

  assignimages({List<dynamic>? listInteresr}) {
    if (listInteresr != null) {
      userimages = listInteresr;
    }

    notifyListeners();
  }
}
