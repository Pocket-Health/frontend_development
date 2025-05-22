import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../model/model.dart';

class SettingsRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<int> getSettings() async {
    final url = dotenv.env['CHAT_HISTORY_URL'].toString();
    final String? accessToken = await _secureStorage.read(key: 'accessToken');
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (response.statusCode == 200) {
        final settings = Settings.fromJson(response.data);
        final box = Hive.box<Settings>('settingsBox');
        await box.put('settings', settings);
        return 200;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<int> enableNotification() async {
    final url = dotenv.env['ENABLE_NOTIFICATION_URL'].toString();
    final String? accessToken = await _secureStorage.read(key: 'accessToken');
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (response.statusCode == 200) {
        final box = Hive.box<Settings>('settingsBox');
        final settings = box.get('settings');
        settings?.notification = true;
        await box.put('settings', settings!);
        return 200;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<int> disableNotification() async {
    final url = dotenv.env['DISABLE_NOTIFICATION_URL'].toString();
    final String? accessToken = await _secureStorage.read(key: 'accessToken');
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (response.statusCode == 200) {
        final box = Hive.box<Settings>('settingsBox');
        final settings = box.get('settings');
        settings?.notification = false;
        await box.put('settings', settings!);
        return 200;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<int> changePassword(String oldPassword, String newPassword) async {
    final url = dotenv.env['CHANGE_PASSWORD_URL'].toString();
    final String? accessToken = await _secureStorage.read(key: 'accessToken');
    try {
      final response = await _dio.put(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword
        }
      );
      if (response.statusCode == 200) {
        return 200;
      } else if (response.statusCode == 400) {
        return 400;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }
}