// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_schedule_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicationScheduleListAdapter
    extends TypeAdapter<MedicationScheduleList> {
  @override
  final int typeId = 5;

  @override
  MedicationScheduleList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicationScheduleList(
      schedules: (fields[0] as List).cast<MedicationSchedule>(),
    );
  }

  @override
  void write(BinaryWriter writer, MedicationScheduleList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.schedules);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicationScheduleListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
