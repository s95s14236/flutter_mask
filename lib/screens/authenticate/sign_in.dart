import 'package:flutter/material.dart';
import 'package:order/services/auth.dart';
import 'package:order/shared/buttonCont.dart';
import 'package:order/shared/constants.dart';
import 'package:order/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  // GlobalKey可用來處理widget間的資料通訊，<FormState>則用來對應FormWidget的狀態
  final _formKey = GlobalKey<FormState>();
  // 若驗證後設為true並loading
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[10],
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        elevation: 0.0,
        title: Text('登入 藥局口罩系統'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(
              '註冊',
              style: TextStyle(),
            ),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: loading
          ? PopLoading()
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/mask_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                        ),
                        validator: (eval) =>
                            eval.isEmpty ? 'Enter the Email' : null,
                        onChanged: (eval) {
                          setState(() => email = eval);
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                            //fillColor: Colors.grey[200],
                          ),
                          validator: (pval) => pval.length < 8
                              ? 'Enter the password 8+ chars long'
                              : null,
                          obscureText: true, // 隱藏密碼
                          onChanged: (pval) {
                            setState(() => password = pval);
                          }),
                      SizedBox(height: 40.0),
                      /*RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              //驗證格式後顯示loading並存取firebase auth
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Email or Password is not correct';
                                  // 若無法登入則關閉loading
                                  loading = false;
                                });
                              }
                            }
                          }),*/
                      ButtonContainer(
                          text: 'Sign In',
                          tap: () async {
                            if (_formKey.currentState.validate()) {
                              //驗證格式後顯示loading並存取firebase auth
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Email or Password is not correct';
                                  // 若無法登入則關閉loading
                                  loading = false;
                                });
                              }
                            }
                          }),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
