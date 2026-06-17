// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSettingAdapter extends TypeAdapter<UserSetting> {
  @override
  final typeId = 2;

  @override
  UserSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSetting(darkMode: fields[0] as bool);
  }

  @override
  void write(BinaryWriter writer, UserSetting obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.darkMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
