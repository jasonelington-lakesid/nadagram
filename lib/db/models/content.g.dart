// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NadagramContentAdapter extends TypeAdapter<NadagramContent> {
  @override
  final typeId = 0;

  @override
  NadagramContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NadagramContent(
      title: fields[0] as String,
      description: fields[1] as String,
      imagePath: fields[2] as String,
      likeCount: (fields[3] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, NadagramContent obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.likeCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NadagramContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
