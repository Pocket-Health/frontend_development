// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicalCardAdapter extends TypeAdapter<MedicalCard> {
  @override
  final int typeId = 0;

  @override
  MedicalCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicalCard(
      fullName: fields[0] as String,
      height: fields[1] as int,
      weight: fields[2] as double,
      bloodType: fields[3] as String,
      allergies: fields[4] as String,
      diseases: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MedicalCard obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.bloodType)
      ..writeByte(4)
      ..write(obj.allergies)
      ..writeByte(5)
      ..write(obj.diseases);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicalCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
