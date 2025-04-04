import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.lightGreen[100],
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.lightGreen[800]),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
  ),
);
