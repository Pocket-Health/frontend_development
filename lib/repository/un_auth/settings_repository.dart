import 'package:hive/hive.dart';

import '../../model/model.dart';
import '../../service/service.dart';

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
        await NotificationService().scheduleAllUnAuthNotifications();
        return 1;
      } else {
        await NotificationService().cancelAllNotifications();
        return 0;
      }
    } else {
      return 2;
    }
  }
}