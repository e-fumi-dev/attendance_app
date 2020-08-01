import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_member_model.dart';

class MemberAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddMemberModel>(
      create: (_) => AddMemberModel(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('社員追加'),
            backgroundColor: Colors.black87,
            centerTitle: true,
            elevation: 0.0,
          ),
          body: Consumer<AddMemberModel>(
            builder: (context, model, child) {
              return Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: '社員名',
                      hintText: '野田太郎',
                      icon: Icon(Icons.account_box),
                    ),
                    onChanged: (text) {
                      model.memberName = text;
                    },
                  ),
                  RaisedButton(
                    child: Text('社員を追加する'),
                    onPressed: () async {
                      if (model.memberName != null) {
                        await _addMember(model, context);
                        await _showDialog(context, '社員を登録しました。');
                      } else {
                        await _showDialog(context, '社員名を入力してください');
                      }
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future _addMember(AddMemberModel model, BuildContext context) async {
    await model.addMemberFile();
  }

  _showDialog(
    BuildContext context,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
