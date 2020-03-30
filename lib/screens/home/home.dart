import 'package:flutter/material.dart';
import 'package:order/models/mask.dart';
import 'package:order/screens/home/mask_list.dart';
import 'package:order/screens/home/setting_form.dart';
import 'package:order/services/auth.dart';
import 'package:order/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      // 彈出底部菜單
      // builder: 一個函數return widget tree(佈局) 給這個bottomsheet
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: SettingForm(),
            );
          });
    }

    // StreamProvider <datatype> 持續監聽Stream QuerySnapshot轉成List<Mask>的資料
    return StreamProvider<List<Mask>>.value(
      value: DatabaseService().mask,
      child: Scaffold(
        backgroundColor: Colors.grey[10],
        appBar: AppBar(
          title: Text('口罩清單'),
        backgroundColor: Colors.cyan[600],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Log Out'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Setting'),
              onPressed: () => _showSettingPanel(),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/mask_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: MaskList(),),
      ),
    );
  }
}
