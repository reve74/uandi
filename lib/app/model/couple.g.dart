// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couple.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoupleAdapter extends TypeAdapter<Couple> {
  @override
  final int typeId = 1;

  @override
  Couple read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Couple(
      selectedDate: fields[0] as DateTime?,
      backgroundImage: fields[1] as String?,
      circleAvatar1: fields[2] as String?,
      circleAvatar2: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Couple obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.selectedDate)
      ..writeByte(1)
      ..write(obj.backgroundImage)
      ..writeByte(2)
      ..write(obj.circleAvatar1)
      ..writeByte(3)
      ..write(obj.circleAvatar2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoupleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
