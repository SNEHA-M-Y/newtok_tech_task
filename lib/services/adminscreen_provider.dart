import 'package:flutter/material.dart';

class AdminscreenProvider extends ChangeNotifier {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  dynamic addLocationAccess;

  void locationAccess() {
    addLocationAccess = <String, String>{
      "country": countryValue,
      "state": stateValue,
      "city": cityValue
    };
    notifyListeners();
  }
}
