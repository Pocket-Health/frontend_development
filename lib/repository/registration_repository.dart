import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegistrationRepository {
  final Dio _dio = Dio();

  Future<int> checkEmail({required String email, required String password}) async {
    final url = dotenv.env['REGISTRATION_USER_URL'].toString();
    try {
      final response = await _dio.post(
        url,
        data: {
          "email": email,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        return 200;
      } else if (response.statusCode == 409) {
        return 409;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<int> registration({required String email, required String password, required String fullName, required String height, required String weight, required String bloodType, required String allergies, required String diseases}) async {
    final url = dotenv.env['REGISTRATION_MEDICAL_CARD_URL'].toString();
    try {
      final response = await _dio.post(
        url,
        data: {
          "email": email,
          "password": password,
          "confirmPassword": password,
          "fullName": fullName,
          "height": height,
          "weight": weight,
          "bloodType": bloodType,
          "allergies": allergies == '' ? 'None' : allergies,
          "diseases": diseases == '' ? 'None' : diseases
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 201) {
        return 201;
      } else if (response.statusCode == 409) {
        return 409;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }
}