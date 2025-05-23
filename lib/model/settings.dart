import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 3)
class Settings extends HiveObject {
  @HiveField(0)
  late bool notification;

  Settings({
    required this.notification
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      notification: json['notification']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification': notification
    };
  }
}