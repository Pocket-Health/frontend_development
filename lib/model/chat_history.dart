import 'package:hive/hive.dart';

part 'chat_history.g.dart';

@HiveType(typeId: 1)
class ChatHistory extends HiveObject {
  @HiveField(0)
  List<Map<String, dynamic>> messages;

  ChatHistory({required this.messages});

  factory ChatHistory.fromJson(Map<String, dynamic> json) => ChatHistory(
    messages: (json['messages'] as List)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'messages': messages,
  };
}
