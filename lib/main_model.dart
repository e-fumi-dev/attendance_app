import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainModel extends ChangeNotifier {
  String memberName = '';
  List<String> memberList = [];

  /*
  void setMemberName(String text) {
    memberName = text;
    notifyListeners();
  }
  */

  Future readMemberList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberList = prefs.getStringList("members");
    if (memberList != null) {
      memberList.insert(0, '');
    } else {
      memberList.add('');
    }
    notifyListeners();
  }
}
