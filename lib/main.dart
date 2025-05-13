import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_development/pocket_health_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const PocketHealthApp());
}
