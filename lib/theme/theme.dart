import 'package:flutter/material.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: Color(0xFF242C3B),
  primarySwatch: Colors.blue,
  textTheme: TextTheme(
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 35,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: Color.fromARGB(200, 36, 44, 59),
      fontSize: 25,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      color: Color.fromARGB(200, 36, 44, 59),
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
  ),
);
