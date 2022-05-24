import 'package:flutter/material.dart';

abstract class MyStyle {
  static const normal = TextStyle(color: Colors.black, fontSize: 15);
  static const bold = TextStyle(color: Colors.black, fontSize: 18);
  static const whiteBold = TextStyle(color: Colors.white, fontSize: 18);
  static const id = TextStyle(color: Colors.white, fontSize: 25);
  static const title =
      TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold);
}
