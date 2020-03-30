import 'package:flutter/material.dart';
import 'package:order/models/user.dart';
import 'package:order/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:order/screens/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // StreamProvider <datatype> 持續監聽Stream user資料
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
