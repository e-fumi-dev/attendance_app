import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberListModel extends ChangeNotifier {
  List<String> memberList = [];

  Future readMemberList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberList = prefs.getStringList("members");
    notifyListeners();
  }

  Future deleteMember(String memberName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberList = prefs.getStringList("members");

    //引数対象のindexを取得
    var index = memberList.indexOf(memberName);

    //引数で渡されたメンバーを削除
    memberList.removeAt(index);

    //SharedPreferencesに再登録
    await prefs.setStringList("members", memberList);

    notifyListeners();
  }
}
