import 'package:hive/hive.dart';

import '../../model/model.dart';

class MedicationScheduleRepository {
  Future<void> addMedicationSchedule(MedicationSchedule medicationSchedule) async {
    final box = Hive.box<MedicationScheduleList>('unAuthMedicationScheduleListBox');
    final medicationScheduleList = box.get('medicationScheduleList') ?? MedicationScheduleList(schedules: []);
    medicationScheduleList.schedules.add(medicationSchedule);
    await box.put('medicationScheduleList', medicationScheduleList);
  }

  Future<void> editMedicationSchedule(MedicationSchedule medicationSchedule) async {
    final box = Hive.box<MedicationScheduleList>('unAuthMedicationScheduleListBox');
    final medicationScheduleList = box.get('medicationScheduleList') ?? MedicationScheduleList(schedules: []);
    final index = medicationScheduleList.schedules.indexWhere((schedule) => schedule.id == medicationSchedule.id);
    medicationScheduleList.schedules[index] = medicationSchedule;
    await box.put('medicationScheduleList', medicationScheduleList);
  }

  Future<void> deleteMedicationSchedule(String id) async {
    final box = Hive.box<MedicationScheduleList>('unAuthMedicationScheduleListBox');
    final medicationScheduleList = box.get('medicationScheduleList') ?? MedicationScheduleList(schedules: []);
    medicationScheduleList.schedules.removeWhere((schedule) => schedule.id == id);
    await box.put('medicationScheduleList', medicationScheduleList);
  }
}