// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemoAdapter extends TypeAdapter<Memo> {
  @override
  final int typeId = 2;

  @override
  Memo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Memo(
      selectedDate: fields[0] as DateTime?,
      text: fields[1] as String,
      id: fields[2] as int,
      color: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Memo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.selectedDate)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
