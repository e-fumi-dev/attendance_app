import 'package:attendanceapp/header.dart';
import 'package:flutter/cupertino.dart';
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
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton.icon(
                      icon: Icon(Icons.wb_sunny),
                      label: Text(
                        "出勤",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton.icon(
                      icon: Icon(Icons.directions_run),
                      label: Text(
                        "退勤",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton.icon(
                  icon: Icon(Icons.free_breakfast),
                  label: Text(
                    "休憩開始",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  color: Colors.lightGreen,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton.icon(
                  icon: Icon(Icons.free_breakfast),
                  label: Text(
                    "休憩終了",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  color: Colors.lightGreen,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
