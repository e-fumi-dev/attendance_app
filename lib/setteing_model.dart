import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingModel extends ChangeNotifier {
  String mailAddressTo = '';
  String mailAddressBcc = '';

  void setMailAddressTo(String text) {
    mailAddressTo = text;
    notifyListeners();
  }

  void setMailAddressBcc(String text) {
    mailAddressBcc = text;
    notifyListeners();
  }

  Future setFileAddress() async {
    List<String> addressList = [];
    if (mailAddressTo.isEmpty) {
      throw ('宛先のメールアドレスを入力してください');
    }
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
    mailAddressTo = (addressList[0].toString() ?? '');
    mailAddressBcc = (addressList[1].toString() ?? '');
    notifyListeners();
  }
}
