import 'package:hive/hive.dart';

import '../../model/model.dart';

class SettingsRepository {

  void initSettings() {
    final box = Hive.box<Settings>('unAuthSettingsBox');
    box.put('settings', Settings(notification: true));
  }

  Future<int> toggleNotification() async {
    final box = Hive.box<Settings>('unAuthSettingsBox');
    final settings = box.get('settings');
    if (settings != null) {
      settings.notification = !settings.notification;
      await box.put('settings', settings);
      if (settings.notification) {
        return 1;
      } else {
        return 0;
      }
    } else {
      return 2;
    }
  }
}