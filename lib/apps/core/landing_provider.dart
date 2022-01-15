import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LandingProvider extends ChangeNotifier {
  int selectedIndex = 0;
  DateTime? currentBackPressTime;

  setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  implementDoubleTapExit() {
    if (selectedIndex == 0) {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(
          msg: "Please double tap to exit",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        return Future.value(false);
      }
      return Future.value(true);
    } else {
      setSelectedIndex(0);
      return false;
    }
  }
}
