import 'package:attendanceapp/setteing_model.dart';
import 'package:email_validator/email_validator.dart';
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
                        //TOの空チェック
                        if (mailToTextEditingController.text != '') {
                          //TOの形式チェック
                          if (EmailValidator.validate(
                              mailToTextEditingController.text)) {
                            //CCの空チェック
                            if (mailBccTextEditingController.text != '') {
                              //CCの形式チェック
                              if (EmailValidator.validate(
                                  mailBccTextEditingController.text)) {
                                await model.setFileAddress();
                              } else {
                                _showDialog(
                                    context, '宛先（CC）はメールアドレス形式で入力してください。');
                              }
                            } else {
                              //TOのみの場合、CCはからでも登録
                              await model.setFileAddress();
                            }
                          } else {
                            _showDialog(context, '宛先（TO）はメールアドレス形式で入力してください。');
                          }
                        } else {
                          _showDialog(context, '宛先（TO）は必須です。');
                        }
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

  Future _showDialog(
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
