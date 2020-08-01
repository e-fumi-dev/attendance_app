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
              return listDisplay(context, model, members);
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
  Widget listDisplay(BuildContext context, MemberListModel model, var members) {
    //リストが有件の場合
    if (members != null) {
      if (model.memberList.length != 0) {
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
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        print(item);
                        await deleteMember(context, model, item);
                        await model.readMemberList();
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

  //メンバー削除
  Future deleteMember(
      BuildContext context, MemberListModel model, String memberName) async {
    try {
      await model.deleteMember(memberName);
      _showDialog(context, '対象の社員を削除いたしました。');
    } catch (e) {
      print(e.toString());
    }
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
