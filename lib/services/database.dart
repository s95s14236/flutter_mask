import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order/models/mask.dart';
import 'package:order/models/user.dart';

class DatabaseService {

  // 當呼叫此函數必須輸入uid參數 (uid: ***)
  // 宣告參數 創建一個Constructor提供參數inject the callback (構造函數用於初始化實例變量)
  // https://medium.com/flutterdevs/working-with-callback-in-flutter-89dc207cba37
  final String uid;
  DatabaseService({ this.uid }); // this:一個隱含的對象指向當前的對象
  /*  上下兩個構造函數是 "一樣的"
  DatabaseService(String uid) {
    this.uid = String uid;
  }
  */

  // collection reference
  // 若該collection不存在，firestore自動新增
  final CollectionReference maskCollection  = Firestore.instance.collection('mask');

  // 1.用戶註冊後建立document 2.進行CRUD
  Future upateUserData(String name, int mask, String color) async {
    // 根據用戶uid開啟particular document 若不存在自動建立 (setDate更新 用map{})
    return await maskCollection.document(uid).setData({
      'name': name,
      'mask': mask,
      'color': color,
    });
  }

  // mask list form snapshot
  List<Mask> _maskListFromSnapshot(QuerySnapshot snapshot) {
    // 返回 each document 的 3個value (Map Iterable 轉成 List)
    return snapshot.documents.map((doc) {
      return Mask(
        name: doc.data['name'] ?? '', // 若不存在則返回 empty String
        mask: doc.data['mask'] ?? 0,
        color: doc.data['color'] ?? '', 
        );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      color: snapshot.data['color'],
      mask: snapshot.data['mask']
    );
  } 



  // get mask Stream (QuerySnapshot: firestore clooection 回傳即時數據)為一個getter
  Stream<List<Mask>> get mask {
    return maskCollection.snapshots()
    .map(_maskListFromSnapshot);
  }

  // get user doc stream 回傳 map<UserData>資料供後續顯示
  Stream<UserData> get userDate {
    return maskCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}