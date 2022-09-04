// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniversary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnniversaryAdapter extends TypeAdapter<Anniversary> {
  @override
  final int typeId = 2;

  @override
  Anniversary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Anniversary(
      selectedDate: fields[0] as DateTime?,
      anniversary: fields[1] as String,
      id: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Anniversary obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.selectedDate)
      ..writeByte(1)
      ..write(obj.anniversary)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnniversaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
