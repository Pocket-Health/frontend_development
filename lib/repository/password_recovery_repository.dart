import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PasswordRecoveryRepository {
  final Dio _dio = Dio();

  Future<int> sendCode({required String email}) async {
    final url = dotenv.env['SEND_CODE_URL'].toString();
    try {
      final response = await _dio.post(
        url,
        data: {"email": email},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (response.statusCode == 200) {
        return 200;
      } else if (response.statusCode == 403) {
        return 403;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<int> checkCode({required String email, required String code}) async {
    final url = dotenv.env['CHECK_CODE_URL'].toString();
    try {
      final response = await _dio.post(
        url,
        data: {"email": email, "code": code},
        options: Options(headers: {'Content-Type': 'application/json'},
            validateStatus: (status) => status != null && status < 500),
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

  Future<int> passwordRecovery({
    required String email,
    required String password,
  }) async {
    final url = dotenv.env['PASSWORD_RECOVERY_URL'].toString();
    try {
      final response = await _dio.post(
        url,
        data: {"email": email, "password": password},
        options: Options(headers: {'Content-Type': 'application/json'},
            validateStatus: (status) => status != null && status < 500),
      );
      if (response.statusCode == 200) {
        return 200;
      } else if (response.statusCode == 403) {
        return 403;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }
}
