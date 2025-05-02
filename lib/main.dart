import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_development/pocket_health_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const PocketHealthApp());
}
