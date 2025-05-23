import 'package:hive/hive.dart';
import 'model.dart';

part 'medication_schedule_list.g.dart';

@HiveType(typeId: 5)
class MedicationScheduleList extends HiveObject {
  @HiveField(0)
  List<MedicationSchedule> schedules;

  MedicationScheduleList({required this.schedules});
}
