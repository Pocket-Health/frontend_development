import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../model/model.dart';

class MedicalCardRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<int> getMedicalCard() async {
    final url = dotenv.env['MEDICAL_CARD_URL'].toString();
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
        final medicalCard = MedicalCard.fromJson(response.data);
        final box = Hive.box<MedicalCard>('medicalCardBox');
        await box.put('medicalCard', medicalCard);
        return 200;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<int> editMedicalCard(MedicalCard medicalCard) async {
    final url = dotenv.env['EDIT_MEDICAL_CARD_URL'].toString();
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
          "fullname": medicalCard.fullName,
          "height": medicalCard.height,
          "weight": medicalCard.weight,
          "blood_type": medicalCard.bloodType,
          "allergies": medicalCard.allergies,
          "diseases": medicalCard.diseases,
        },
      );
      if (response.statusCode == 200) {
        return await getMedicalCard();
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }
}
