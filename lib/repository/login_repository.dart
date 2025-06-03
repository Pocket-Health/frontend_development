import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_development/service/service.dart';
import 'repository.dart';

class LoginRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<bool> getTokens({required String email, required String password}) async {
    final url = dotenv.env['LOGIN_URL'].toString();
    try {
      final response = await _dio.post(
        url,
        data: {
          "email": email,
          "password": password,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final data = response.data;
      final accessToken = data['accessToken'];
      final refreshToken = data['refreshToken'];
      if (accessToken != null && refreshToken != null) {
        await _secureStorage.write(key: 'accessToken', value: accessToken);
        await _secureStorage.write(key: 'refreshToken', value: refreshToken);
        await getData();
        return true;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future getData() async {
    await MedicalCardRepository().getMedicalCard();
    await ChatRepository().getChatHistory();
    await MedicationScheduleRepository().getMedicationSchedule();
    await SettingsRepository().getSettings();
  }

  Future refresh() async {
    final url = dotenv.env['REFRESH_TOKEN_URL'].toString();
    try {
      final response = await _dio.post(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "refreshToken": await _secureStorage.read(key: 'refreshToken'),
        },
      );
      final data = response.data;
      final accessToken = data['accessToken'];
      final refreshToken = data['refreshToken'];
      if (accessToken != null && refreshToken != null) {
        await _secureStorage.write(key: 'accessToken', value: accessToken);
        await _secureStorage.write(key: 'refreshToken', value: refreshToken);
        await getData();
      }
    } catch (e) {
      return e;
    }
  }
}