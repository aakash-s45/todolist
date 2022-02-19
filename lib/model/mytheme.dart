import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = Colors.grey.shade500;
  // static Color primaryColor = const Color.fromARGB(255, 123, 90, 86);
  static const Color secondaryColor = Colors.white;
  static const TextStyle mainTextTileStyle = TextStyle(
    // fontWeight: FontWeight.bold,
    fontSize: 15,
    color: MyTheme.secondaryColor,
  );
  static const TextStyle headingTextTileStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.black,
  );
}
