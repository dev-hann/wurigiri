library chat;

import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

part './chat_text.dart';
part './chat_photo.dart';
part './chat_system.dart';
part './chat_removed.dart';

enum ChatType {
  text,
  photo,
  system,
  removed,
}

abstract class Chat extends Equatable with Comparable<Chat> {
  Chat({
    required this.senderIndex,
    required this.dateTime,
    required this.typeIndex,
  });
  final DateTime dateTime;
  final String senderIndex;
  final int typeIndex;
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
      case ChatType.removed:
        return RemovedChat.fromMap(map);
    }
  }
}
