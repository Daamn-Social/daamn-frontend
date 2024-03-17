import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  File? postimage;

  Future custonImagePIcker({required ImageSource sourceimage}) async {
    final postimage = await ImagePicker().pickImage(source: sourceimage);
    if (postimage == null) return;
    final tem = File(postimage.path);
    this.postimage = tem;
    notifyListeners();
  }

  clean() {
    postimage = null;
    notifyListeners();
  }
}
