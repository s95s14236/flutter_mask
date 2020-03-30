import 'package:flutter/material.dart';
import 'package:smart_color/smart_color.dart';
import 'package:order/models/mask.dart';

class MaskTile extends StatelessWidget {
  final Mask mask;
  MaskTile({this.mask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: SmartColor.parse(mask.color),
            ),
            title: Text(mask.name),
            subtitle: Text('Buy ${mask.mask} masks'),
          ),
        ),
      ),
    );
  }
}
