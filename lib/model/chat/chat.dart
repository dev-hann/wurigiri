library chat;

import 'dart:typed_data';

import 'package:equatable/equatable.dart';

part './chat_text.dart';
part './chat_photo.dart';
part './chat_system.dart';

enum ChatType {
  text,
  photo,
  system,
}

abstract class Chat extends Equatable with Comparable<Chat> {
  const Chat({
    required this.senderIndex,
    required this.dateTime,
    required this.typeIndex,
    this.isDeleted = false,
  });
  final DateTime dateTime;
  final String senderIndex;
  final int typeIndex;
  final bool isDeleted;
  ChatType get type => ChatType.values[typeIndex];

  int get index => dateTime.millisecondsSinceEpoch;

  @override
  int compareTo(Chat other) {
    return index.compareTo(other.index);
  }

  Map<String, dynamic> toMap();

  static Chat fromMap(dynamic map) {
    final typeIndex = map["typeIndex"];
    final type = ChatType.values[typeIndex];
    switch (type) {
      case ChatType.text:
        return TextChat.fromMap(map);
      case ChatType.photo:
        return PhotoChat.fromMap(map);
      case ChatType.system:
        return SystemChat.fromMap(map);
    }
  }
}
