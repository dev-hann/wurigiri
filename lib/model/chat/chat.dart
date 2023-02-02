library chat;

import 'package:equatable/equatable.dart';

part './chat_text.dart';

enum ChatType {
  text,
}

abstract class Chat extends Equatable with Comparable<Chat> {
  const Chat({
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

  static fromMap(dynamic map) {
    final typeIndex = map["typeIndex"];
    final type = ChatType.values[typeIndex];
    switch (type) {
      case ChatType.text:
        return TextChat.fromMap(map);
    }
  }
}
