import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import '../model/model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> initNotification() async {
    if (_initialized) return;

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await notificationPlugin.initialize(initSettings);

    _initialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'medication_schedule_id',
        'Medication Schedule',
        channelDescription: 'Medication Schedule Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    await notificationPlugin.show(id, title, body, notificationDetails());
  }

  Future<void> scheduleAllNotifications() async {
    if (Hive.box<Settings>('settingsBox').get('settings')?.notification ==
        false) {
      return;
    }

    await cancelAllNotifications();

    final box = Hive.box<MedicationScheduleList>('MedicationScheduleListBox');
    final medicationScheduleList = box.get('medicationScheduleList');
    if (medicationScheduleList == null) return;

    int notificationId = 1000;

    for (MedicationSchedule schedule in medicationScheduleList.schedules) {
      for (int weekday in schedule.scheduledDays) {
        for (String time in schedule.scheduledTimes) {
          final parts = time.split(':');
          if (parts.length < 2) continue;

          final hour = int.tryParse(parts[0]);
          final minute = int.tryParse(parts[1]);
          if (hour == null || minute == null) continue;

          tz.TZDateTime scheduledDate = _nextInstanceOfWeekdayTime(
            weekday: weekday,
            hour: hour,
            minute: minute,
          );

          await notificationPlugin.zonedSchedule(
            notificationId++,
            'Напоминание',
            'Пора принять ${schedule.medicationName}',
            scheduledDate,
            notificationDetails(),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          );
        }
      }
    }
  }

  tz.TZDateTime _nextInstanceOfWeekdayTime({
    required int weekday,
    required int hour,
    required int minute,
  }) {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    int daysDifference = ((weekday + 1) - scheduledDate.weekday + 7) % 7;
    if (daysDifference == 0 && scheduledDate.isBefore(now)) {
      daysDifference = 7;
    }

    scheduledDate = scheduledDate.add(Duration(days: daysDifference));
    return scheduledDate;
  }

  Future<void> scheduleAllUnAuthNotifications() async {
    if (Hive.box<Settings>('unAuthSettingsBox').get('settings')?.notification ==
        false) {
      return;
    }

    await cancelAllNotifications();

    final box = Hive.box<MedicationScheduleList>(
      'UnAuthMedicationScheduleListBox',
    );
    final medicationScheduleList = box.get('medicationScheduleList');
    if (medicationScheduleList == null) return;

    int notificationId = 1000;

    for (MedicationSchedule schedule in medicationScheduleList.schedules) {
      for (int weekday in schedule.scheduledDays) {
        for (String time in schedule.scheduledTimes) {
          final parts = time.split(':');
          if (parts.length < 2) continue;

          final hour = int.tryParse(parts[0]);
          final minute = int.tryParse(parts[1]);
          if (hour == null || minute == null) continue;

          tz.TZDateTime scheduledDate = _nextInstanceOfWeekdayTime(
            weekday: weekday,
            hour: hour,
            minute: minute,
          );

          await notificationPlugin.zonedSchedule(
            notificationId++,
            'Напоминание',
            'Пора принять ${schedule.medicationName}',
            scheduledDate,
            notificationDetails(),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          );
        }
      }
    }
  }

  Future<void> cancelAllNotifications() async {
    await notificationPlugin.cancelAll();
  }
}
