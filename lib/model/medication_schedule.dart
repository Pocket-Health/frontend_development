import 'package:hive/hive.dart';

part 'medication_schedule.g.dart';

@HiveType(typeId: 4)
class MedicationSchedule extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String medicationName;

  @HiveField(2)
  List<int> scheduledDays;

  @HiveField(3)
  List<String> scheduledTimes;

  MedicationSchedule({
    required this.id,
    required this.medicationName,
    required this.scheduledDays,
    required this.scheduledTimes,
  });

  factory MedicationSchedule.fromJson(Map<String, dynamic> json) {
    return MedicationSchedule(
      id: json['id'],
      medicationName: json['medicationName'],
      scheduledDays: List<int>.from(json['schedulesDays']),
      scheduledTimes: List<String>.from(json['schedulesTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medication_name': medicationName,
      'days': scheduledDays,
      'times':
          scheduledTimes.map((t) {
            return t.length >= 5 ? t.substring(0, 5) : t;
          }).toList(),
    };
  }
}