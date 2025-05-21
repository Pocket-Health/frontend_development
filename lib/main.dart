import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_development/pocket_health_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/model.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Hive.initFlutter();

  Hive.registerAdapter(MedicalCardAdapter());
  await Hive.openBox<MedicalCard>('medicalCardBox');

  runApp(const PocketHealthApp());
}