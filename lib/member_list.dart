import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'member_add.dart';
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
                },
              );
            },
          ),
        );
      },
    );
  }
}
