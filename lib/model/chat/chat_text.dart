part of chat;

class TextChat extends Chat {
  TextChat({
    required String senderIndex,
    required DateTime dateTime,
    required this.text,
  }) : super(
          senderIndex: senderIndex,
          dateTime: dateTime,
          typeIndex: ChatType.text.index,
        );

  final String text;
  @override
  List<Object?> get props => [
        index,
        dateTime,
        senderIndex,
        text,
      ];

  factory TextChat.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return TextChat(
      senderIndex: data["senderIndex"],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
      text: data["text"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "senderIndex": senderIndex,
      "dateTime": dateTime.millisecondsSinceEpoch,
      "text": text,
    };
  }
}
