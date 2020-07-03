import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String memberName = '';

  void setMemberName(String text) {
    memberName = text;
    notifyListeners();
  }
}
