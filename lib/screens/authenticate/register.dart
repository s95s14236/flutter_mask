import 'package:flutter/material.dart';
import 'package:order/services/auth.dart';
import 'package:order/shared/buttonCont.dart';
import 'package:order/shared/constants.dart';
import 'package:order/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  // GlobalKey 可用來處理widget間的資料通訊
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[20],
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        elevation: 0.0,
        title: Text('信箱註冊'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(
              '登入',
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
                  // 追蹤form的State，並驗證輸入
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                        ),
                        validator: (eval) =>
                            eval.isEmpty ? 'Enter the email' : null,
                        onChanged: (eval) {
                          setState(() => email = eval);
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
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
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            // 驗證所有TextFormField的validator的property，current的輸入 (true || false)
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              // 為何用dynamic? 因為回傳的值可能為 null or user
                              dynamic result = await _auth
                                  .registerWithEmailAndPassword(email, password);
                              if (result == null) {
                                if (_auth.catchError.substring(18, 44) ==
                                    'ERROR_EMAIL_ALREADY_IN_USE') {
                                  setState(() {
                                    error = 'Your email was registered';
                                    loading = false;
                                  });
                                } else {
                                  setState(() {
                                    error = 'Please enter the valid email';
                                    loading = false;
                                  });
                                }
                              }*/
                      /* 這裡不需要else，因為在main.dart有設置StreamProvider
                           當註冊完回傳並取得user state自動轉向已登入Widget
                           else {
                           widget.toggleView();
                           }
                        */
                      //   }
                      // }),
                      ButtonContainer(
                          text: 'Registor',
                          tap: () async {
                            // 驗證所有TextFormField的validator的property，current的輸入 (true || false)
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              // 為何用dynamic? 因為回傳的值可能為 null or user
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                if (_auth.catchError.substring(18, 44) ==
                                    'ERROR_EMAIL_ALREADY_IN_USE') {
                                  setState(() {
                                    error = 'Your email was registered';
                                    loading = false;
                                  });
                                } else {
                                  setState(() {
                                    error = 'Please enter the valid email';
                                    loading = false;
                                  });
                                }
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
