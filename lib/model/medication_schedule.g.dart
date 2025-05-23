// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicationScheduleAdapter extends TypeAdapter<MedicationSchedule> {
  @override
  final int typeId = 4;

  @override
  MedicationSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicationSchedule(
      id: fields[0] as String,
      medicationName: fields[1] as String,
      scheduledDays: (fields[2] as List).cast<int>(),
      scheduledTimes: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MedicationSchedule obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.medicationName)
      ..writeByte(2)
      ..write(obj.scheduledDays)
      ..writeByte(3)
      ..write(obj.scheduledTimes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicationScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
