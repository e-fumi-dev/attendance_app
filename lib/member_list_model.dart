import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberListModel extends ChangeNotifier {
  List<String> memberList = [];
  var listItem = ["野田太郎", "野田次郎", "野田三郎"];

  Future readMemberList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //memberList = prefs.getStringList("members");

    if (prefs.getStringList("members") == null) {
      memberList.add("社員を追加してください。");
    } else {
      memberList = prefs.getStringList("members");
    }

    //memberList = listItem;
    notifyListeners();
  }
}
