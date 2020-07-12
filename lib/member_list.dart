import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'member_list_model.dart';

//TODO shared_preferenceを利用して社員一覧の表示、追加削除を可能とする。
class MemberListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemberListModel>(
      create: (_) => MemberListModel()..readMemberList(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('社員一覧'),
            backgroundColor: Colors.black87,
            centerTitle: true,
            elevation: 0.0,
          ),
          body: Consumer<MemberListModel>(
            builder: (context, model, child) {
              final members = model.memberList;
              return ListView(
                children: <Widget>[
                  for (var item in members)
                    ListTile(
                      title: Text(item),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
