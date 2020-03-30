import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  //fillColor: Colors.grey, // filled: true才能顯示
  filled: true,
  enabledBorder: OutlineInputBorder(
    // 呈現若FormField沒被選取
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    // 呈現若FormField被選取
    borderSide: BorderSide(
      color: Colors.pink,
      width: 2.0,
    ),
  ),
);


