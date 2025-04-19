import 'package:flutter/material.dart';
import 'package:frontend_development/router/router.dart';
import 'package:frontend_development/theme/theme.dart';

class PocketHealthApp extends StatelessWidget {
  const PocketHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: routes,
    );
  }
}