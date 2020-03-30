import 'package:flutter/material.dart';
import 'package:order/services/database.dart';
import 'package:order/shared/buttonCont.dart';
import 'package:order/shared/constants.dart';
import 'package:order/models/user.dart';
import 'package:order/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:smart_color/smart_color.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  // GlobalKey可用來處理widget間的資料通訊，<FormState>則用來對應FormWidget的狀態
  final _formKey = GlobalKey<FormState>();
  // size Dropdown 選項
  final List<String> color = ['blue', 'green', 'white', 'black'];

  // form 更改values 的暫存變數
  String _currentName;
  String _currentColor;
  int _currentMask;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // 監聽根據 個別uid user data
    // 2種方式: 1. StreamProvider<>.value(value,child) 2. StreamBuilder<>(stream, builder)
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userDate,
        builder: (context, snapshot) {
          // 這裡的snapshot是Stream獲得的即時數據(與firbase snapshot無關)
          if (snapshot.hasData) {
            //等獲取firebase資料，才return Widget(防止資料衝突)

            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  children: <Widget>[
                    Text(
                      // title
                      "請輸入'名字', 訂購口罩'顏色'及'數量'",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSanseTC',
                          letterSpacing: 1.0),
                    ),
                    SizedBox(height: 40.0),
                    // name TextField
                    settingLabel('Name'),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your Name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 20.0),
                    // color dropdown
                    settingLabel('顏色'),
                    DropdownButtonFormField(
                      value: _currentColor ?? userData.color,
                      decoration: textInputDecoration.copyWith(
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0)),
                      items: color.map((color) {
                        return DropdownMenuItem(
                          value: color,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 20),
                              CircleAvatar(
                                backgroundColor: SmartColor.parse(color),
                                radius: 12.0,
                              ),
                              SizedBox(width: 20.0),
                              Text(color),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentColor = val),
                    ),
                    SizedBox(height: 20.0),
                    // masks slider
                    settingLabel('口罩數量'),
                    Slider(
                      value: (_currentMask ?? 10.1).toDouble(),
                      label: '$_currentMask',
                      activeColor: Colors.cyanAccent[400],
                      inactiveColor: Colors.cyanAccent[400],
                      min: 10.0,
                      max: 200.0,
                      divisions: 19,
                      onChanged: (val) =>
                          setState(() => _currentMask = val.round()),
                    ),
                    SizedBox(height: 20.0),
                    /*RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: userData.uid).upateUserData(
                            _currentName ?? userData.name, // ?? : null-aware oprator
                            _currentMask ?? userData.mask, // 除非變量為null，否則請執行此操作
                            _currentColor ?? userData.color // 若沒更改則設為原value
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),*/
                    ButtonContainer(text: 'Update',
                    tap: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: userData.uid).upateUserData(
                            _currentName ?? userData.name, // ?? : null-aware oprator
                            _currentMask ?? userData.mask, // 除非變量為null，否則請執行此操作
                            _currentColor ?? userData.color // 若沒更改則設為原value
                          );
                          Navigator.pop(context);
                        }
                      })
                  ],
                ),
              ),
            );
          } else {
            return PopLoading();
          }
        });
  }
}

Widget settingLabel(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 18.0, color: Colors.grey[600], fontFamily: 'NotoSansTC', letterSpacing: 1.0),
    ),
  );
}
