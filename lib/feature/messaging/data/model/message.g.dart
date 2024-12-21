// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 0;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      isDate: fields[3] as bool,
      sender: fields[2] as String,
      content: fields[0] as String,
      time: fields[1] as String,
      id: fields[11] as int,
      isGIF: fields[4] as bool,
      isReply: fields[5] as bool,
      isForward: fields[6] as bool,
      participantId: fields[7] as String,
      isPinned: fields[9] as bool,
      isDraft: fields[8] as bool,
      replyMessage: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.sender)
      ..writeByte(3)
      ..write(obj.isDate)
      ..writeByte(4)
      ..write(obj.isGIF)
      ..writeByte(5)
      ..write(obj.isReply)
      ..writeByte(6)
      ..write(obj.isForward)
      ..writeByte(7)
      ..write(obj.participantId)
      ..writeByte(8)
      ..write(obj.isDraft)
      ..writeByte(9)
      ..write(obj.isPinned)
      ..writeByte(10)
      ..write(obj.replyMessage)
      ..writeByte(11)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
