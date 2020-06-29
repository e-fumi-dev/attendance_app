import 'package:attendanceapp/header.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
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
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child:
                          _buttonArea(Icons.wb_sunny, '出勤', Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: _buttonArea(
                          Icons.directions_run, '退勤', Colors.redAccent),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: _buttonArea(
                    Icons.free_breakfast, '休憩開始', Colors.lightGreen),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: _buttonArea(
                    Icons.free_breakfast, '休憩終了', Colors.lightGreen),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonArea(IconData icon, String label, Color color) {
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
      onPressed: () {},
    );
  }
}
