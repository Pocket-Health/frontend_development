import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_development/pocket_health_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_development/repository/un_auth/un_auth_repository.dart';
import 'package:frontend_development/service/service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/model.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Hive.initFlutter();

  Hive.registerAdapter(MedicalCardAdapter());
  await Hive.openBox<MedicalCard>('medicalCardBox');

  Hive.registerAdapter(ChatHistoryAdapter());
  await Hive.openBox<ChatHistory>('chatHistoryBox');

  Hive.registerAdapter(SettingsAdapter());
  await Hive.openBox<Settings>('settingsBox');

  Hive.registerAdapter(MedicationScheduleAdapter());
  Hive.registerAdapter(MedicationScheduleListAdapter());
  await Hive.openBox<MedicationScheduleList>('medicationScheduleListBox');

  await Hive.openBox<Settings>('unAuthSettingsBox');
  if (Hive.box<Settings>('unAuthSettingsBox').get('settings') == null) {
    SettingsRepository().initSettings();
  }

  await Hive.openBox<MedicationScheduleList>('unAuthMedicationScheduleListBox');

  AppMetrica.activate(AppMetricaConfig(dotenv.env['APP_METRICS_API_KEY'].toString(), sessionsAutoTrackingEnabled: true));

  await NotificationService().initNotification();

  runApp(const PocketHealthApp());
}
