import 'package:flutter/material.dart';

class WidgetsProvider extends ChangeNotifier {
  List<String> items = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedItem;
  dropDownItem(value) {
    selectedItem = value;
    notifyListeners();
  }
}
