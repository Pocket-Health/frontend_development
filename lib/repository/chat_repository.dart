import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../model/model.dart';

class ChatRepository {

  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<int> getChatHistory() async {
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
        final chatHistory = ChatHistory.fromJson(response.data);
        final box = Hive.box<ChatHistory>('chatHistoryBox');
        await box.put('chatHistory', chatHistory);
        return 200;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<int> sendQuestion({required String question}) async {
    final url = dotenv.env['SEND_QUESTION_URL'].toString();
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
        data: {
          "message": question,
        },
      );
      if (response.statusCode == 200) {
        return await getChatHistory();
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }
}