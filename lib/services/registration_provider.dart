import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  List<String> choice = ["User", "Admin"];

  String choiceSelected = "User";
  String userOrAdmin = "User";
  void dropDownVariable(UpdatedChoiceselected) {
    choiceSelected = UpdatedChoiceselected!;
    userOrAdmin = UpdatedChoiceselected;
    notifyListeners();
  }
}
