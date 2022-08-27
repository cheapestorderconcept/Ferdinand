import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingIndicator {
  static showProgres() {
    return EasyLoading.show(
        indicator: const CircularProgressIndicator(
      strokeWidth: 4.0,
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
    ));
  }
}
