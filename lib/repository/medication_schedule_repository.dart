import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../model/model.dart';

class MedicationScheduleRepository {
  final _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<int> getMedicationSchedule() async {
    final url = dotenv.env['MEDICATION_SCHEDULE_URL'].toString();
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
        final List<dynamic> jsonList = response.data;
        final MedicationScheduleList medicationScheduleList =
            MedicationScheduleList(
              schedules:
                  jsonList
                      .map(
                        (item) => MedicationSchedule.fromJson(
                          item as Map<String, dynamic>,
                        ),
                      )
                      .toList(),
            );
        final box = Hive.box<MedicationScheduleList>('medicationScheduleListBox');
        await box.put('medicationScheduleList', medicationScheduleList);
        return 200;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<int> addMedicationSchedule(MedicationSchedule medicationSchedule) async {
    final url = dotenv.env['ADD_MEDICATION_SCHEDULE_URL'].toString();
    final String? accessToken = await _secureStorage.read(key: 'accessToken');
    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
        data: medicationSchedule.toJson(),
      );
      if (response.statusCode == 201) {
        await getMedicationSchedule();
        return 201;
      } else if (response.statusCode == 400) {
        return 400;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<int> editMedicationSchedule(MedicationSchedule medicationSchedule) async {
    final url = dotenv.env['EDIT_MEDICATION_SCHEDULE_URL'].toString() + '/${medicationSchedule.id}';
    final String? accessToken = await _secureStorage.read(key: 'accessToken');
    print(medicationSchedule.toJson());
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
        data: medicationSchedule.toJson(),
      );
      if (response.statusCode == 200) {
        return await getMedicationSchedule();
      } else if (response.statusCode == 404) {
        return 404;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<int> deleteMedicationSchedule(String id) async {
    final url = dotenv.env['DELETE_MEDICATION_SCHEDULE_URL'].toString() + '/$id';
    final String? accessToken = await _secureStorage.read(key: 'accessToken');
    try {
      final response = await _dio.delete(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (response.statusCode == 204) {
        await getMedicationSchedule();
        return 204;
      } else if (response.statusCode == 404) {
        return 404;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }
}
