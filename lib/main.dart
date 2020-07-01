import 'package:attendanceapp/header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  /*メーラー起動用設定
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'msfm0812@outlook.jp', //なにかローカルのファイルorＤＢに値を持っておく。（別画面で登録）
      queryParameters: {
        'subject': 'Example Subject & Symbols are allowed!',
        'body': 'test'
      });
   */

  @override
  Widget build(BuildContext context) {
    String subjectName = '';

    return Scaffold(
      appBar: Header(),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: '氏名',
                  hintText: '野田　太郎',
                  icon: Icon(Icons.person),
                ),
                autocorrect: false,
                autofocus: true,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  subjectName = text;
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: _buttonArea(
                          Icons.wb_sunny, '出勤', Colors.blueAccent, subjectName),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: _buttonArea(Icons.directions_run, '退勤',
                          Colors.redAccent, subjectName),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: _buttonArea(Icons.free_breakfast, '休憩開始',
                    Colors.lightGreen, subjectName),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: _buttonArea(Icons.free_breakfast, '休憩終了',
                    Colors.lightGreen, subjectName),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ボタン制御
  // ボタン内の表示内容（アイコン、ラベル、ボタンカラー）
  Widget _buttonArea(
      IconData icon, String label, Color color, String subjectName) {
    var email = 'test@example.com';
    var subject = '【勤怠連絡】';
    var body = '';
    var url = '';

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
        subject = subject + subjectName;
        body = label;
        url = 'mailto:$email?subject=$subject&body=$body';
        launch(url);
      },
    );
  }
}
