part of chat;

class TrashChat extends Chat {
  TrashChat({
    required super.senderIndex,
    required super.dateTime,
  }) : super(typeIndex: ChatType.trash.index);
  @override
  List<Object?> get props => [
        index,
        dateTime,
        senderIndex,
      ];

  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "senderIndex": senderIndex,
      "dateTime": dateTime.millisecondsSinceEpoch,
    };
  }

  factory TrashChat.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return TrashChat(
      senderIndex: data["senderIndex"],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
    );
  }
}
