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
                    onChanged: (text) {},
                  ),
                  RaisedButton(
                    child: Text('社員を追加する'),
                    onPressed: () async {
                      await AddMember(model, context);
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

  Future AddMember(AddMemberModel model, BuildContext context) async {
    await model.addMemberFile();
  }
}
