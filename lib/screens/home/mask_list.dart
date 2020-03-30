import 'package:flutter/material.dart';
import 'package:order/models/mask.dart';
import 'package:order/screens/home/mask_tile.dart';
import 'package:provider/provider.dart';


// 用戶登入後顯示介面
class MaskList extends StatefulWidget {
  @override
  _MaskListState createState() => _MaskListState();
}

class _MaskListState extends State<MaskList> {
  @override
  Widget build(BuildContext context) {

    // 從Stream存取基於firebase collection 目前的data
    final mask = Provider.of<List<Mask>>(context) ?? []; // 若還沒load進list, 則先為空防止錯誤出現
    //print(mask.documents);
    mask.forEach((mask) {
      print(mask.name);
      print(mask.mask);
      print(mask.color);
    });

    return ListView.builder(
      itemCount: mask.length,
      itemBuilder: (context, index) {
        return MaskTile(mask: mask[index]);
      }, 
    );
  }
}