import 'package:flutter/material.dart';

//TODO shared_preferenceを利用して社員一覧の表示、追加削除を可能とする。
class MemberListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('社員一覧'),
        backgroundColor: Colors.black87,
        centerTitle: true,
        elevation: 0.0,
      ),
    );
  }
}
