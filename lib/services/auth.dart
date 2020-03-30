import 'package:firebase_auth/firebase_auth.dart';
import 'package:order/models/user.dart';
import 'package:order/services/database.dart';

class AuthService {
  // 宣告firebase auth方法的實例 ( _參數 : 只為這個檔案私有，別的檔案不能用) (final : 不能更改)
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String catchError = '';

  // create user obj based on FirebaseUser (判斷是否登入並透過uesr model傳回uid)
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream ( Stream(流) 為一個異步處理資料流的機器 )
  // https://www.youtube.com/watch?v=nQBpOIHE4eE
  // https://medium.com/dartlang/dart-asynchronous-programming-streams-2569a993324d
  Stream<User> get user {
    // 當接收firebase user 資料時呼叫User抓uid函數
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try { 
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      catchError = e.toString();
      print(catchError);
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      
      // 當用戶註冊時，根據uid create一個document給user
      await DatabaseService(uid: user.uid).upateUserData('New member', 0, 'blue');

      return _userFromFirebaseUser(user);
    } catch (e) {
      catchError = e.toString();
      print(catchError);
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
