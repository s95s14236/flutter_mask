import 'package:flutter/material.dart';
import 'package:order/models/user.dart';
import 'package:order/screens/authenticate/authenticate.dart';
import 'package:order/screens/home/home.dart';
import 'package:provider/provider.dart';

// Wrapper 用來trigger登入及登出介面
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 當存取每次User data 得到新的值
    final user = Provider.of<User>(context);
    print(user);

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}