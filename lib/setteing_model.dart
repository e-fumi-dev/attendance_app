import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingModel extends ChangeNotifier {
  String mailAddressTo = '';
  String mailAddressBcc = '';

  Future setMailAddressTo(String text) async {
    mailAddressTo = text;
    //notifyListeners();
  }

  Future setMailAddressBcc(String text) async {
    mailAddressBcc = text;
    //notifyListeners();
  }

  Future setFileAddress() async {
    List<String> addressList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addressList.add(mailAddressTo);
    addressList.add(mailAddressBcc);
    await prefs.setStringList("address", addressList);
    notifyListeners();
  }

  Future readFileAddress() async {
    List<String> addressList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addressList = prefs.getStringList("address");
    if (addressList != null) {
      mailAddressTo = (addressList[0].toString() ?? '');
      mailAddressBcc = (addressList[1].toString() ?? '');
    }
    notifyListeners();
  }
}
