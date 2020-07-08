import 'package:attendanceapp/setteing_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController mailToTextEditingController = TextEditingController();
    TextEditingController mailBccTextEditingController =
        TextEditingController();

    return ChangeNotifierProvider<SettingModel>(
      create: (_) => SettingModel()..readFileAddress(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('設定'),
          backgroundColor: Colors.black87,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Consumer<SettingModel>(
          builder: (context, model, child) {
            mailToTextEditingController.text = model.mailAddressTo;
            mailBccTextEditingController.text = model.mailAddressBcc;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: mailToTextEditingController,
                      decoration: InputDecoration(
                        labelText: 'メールアドレス宛先（TO）',
                        hintText: 'example@ex.co.jp',
                        icon: Icon(Icons.mail_outline),
                      ),
                      onChanged: (text) {
                        model.setMailAddressTo(text);
                        //todo カーソルの制御の確認とバリデータ@が必要みたい。
                      },
                    ),
                    TextField(
                      controller: mailBccTextEditingController,
                      decoration: InputDecoration(
                        labelText: 'メールアドレス宛先（BCC）',
                        hintText: 'example@ex.co.jp',
                        icon: Icon(Icons.mail_outline),
                      ),
                      onChanged: (text) {
                        model.setMailAddressBcc(text);
                      },
                    ),
                    RaisedButton(
                      child: Text('メールアドレスを登録する'),
                      onPressed: () async {
                        await model.setFileAddress();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
