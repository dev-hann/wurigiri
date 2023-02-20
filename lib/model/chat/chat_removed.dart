part of chat;

class RemovedChat extends Chat {
  RemovedChat({
    required super.senderIndex,
    required super.dateTime,
    required this.data,
  }) : super(typeIndex: ChatType.removed.index);
  final dynamic data;

  @override
  List<Object?> get props => [
        index,
        dateTime,
        senderIndex,
        data,
      ];

  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "senderIndex": senderIndex,
      "dateTime": dateTime.millisecondsSinceEpoch,
      "data": data,
    };
  }

  factory RemovedChat.fromChat(Chat chat) {
    return RemovedChat(
      senderIndex: chat.senderIndex,
      dateTime: chat.dateTime,
      data: chat.toMap(),
    );
  }
  factory RemovedChat.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return RemovedChat(
      senderIndex: data["senderIndex"],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
      data: data["data"],
    );
  }
}
