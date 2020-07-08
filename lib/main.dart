import 'package:attendanceapp/header.dart';
import 'package:attendanceapp/main_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      home: MyHomePage(title: 'Attendance Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, List<String>> _dropDownMenu = {
    '野田太郎': [],
    '野田次郎': [],
    '野田三郎': []
  };
  String dropdownValue = '野田太郎';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel(),
      child: Scaffold(
        appBar: Header(),
        body: Consumer<MainModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 30,
                        elevation: 16,
                        style: TextStyle(fontSize: 30, color: Colors.black87),
                        underline: Container(
                          height: 2,
                          color: Colors.black26,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: _dropDownMenu.keys
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: _buttonArea(Icons.wb_sunny, '出勤',
                                  Colors.blueAccent, dropdownValue),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: _buttonArea(Icons.directions_run, '退勤',
                                  Colors.redAccent, model.memberName),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: _buttonArea(Icons.free_breakfast, '休憩開始',
                            Colors.lightGreen, model.memberName),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: _buttonArea(Icons.free_breakfast, '休憩終了',
                            Colors.lightGreen, model.memberName),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ボタン制御
  // ボタン内の表示内容（アイコン、ラベル、ボタンカラー）
  Widget _buttonArea(
      IconData icon, String label, Color color, String subjectName) {
    return RaisedButton.icon(
      icon: Icon(icon),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      color: color,
      textColor: Colors.white,
      onPressed: () {
        funcOpenMailComposer(label, subjectName);
      },
    );
  }

  // メーラー起動メソッド
  void funcOpenMailComposer(String label, String subjectName) async {
    List<String> addressList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addressList = prefs.getStringList("address");

    final mailtoLink = Mailto(
      to: [addressList[0].toString()],
      cc: [addressList[1].toString()],
      subject: '【勤怠連絡】' + subjectName,
      body: label,
    );
    await launch('$mailtoLink');
  }
}
