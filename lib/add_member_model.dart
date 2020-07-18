import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMemberModel extends ChangeNotifier {
  String memberName;
  List<String> memberList = [];

  Future addMemberFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("members") != null) {
      memberList = prefs.getStringList("members");
      memberList.add(memberName);
    } else {
      memberList.add(memberName);
    }
    await prefs.setStringList("members", memberList);
    notifyListeners();
  }
}
