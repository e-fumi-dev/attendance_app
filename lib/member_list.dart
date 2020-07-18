import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'member_add.dart';
import 'member_list_model.dart';

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
              return listDisplay(members);
            },
          ),
          floatingActionButton: Consumer<MemberListModel>(
            builder: (context, model, child) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemberAddPage(),
                      fullscreenDialog: true,
                    ),
                  );
                  await model.readMemberList();
                },
              );
            },
          ),
        );
      },
    );
  }

  //リストのContainerの0件or有件Widget
  Widget listDisplay(var members) {
    //リストが有件の場合
    if (members != null) {
      return Container(
        child: ListView(
          children: <Widget>[
            for (var item in members)
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 5,
                      color: Colors.lightGreen,
                    ),
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.black87,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    item,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      //TODO: deleteメソッド
                    },
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      //リストが0件の場合
      return Container(
        child: Text(
          '社員を1名以上登録してください。',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ); // Empty Container Widget
    }
  }
}
