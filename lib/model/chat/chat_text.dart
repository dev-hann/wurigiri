part of chat;

class TextChat extends Chat {
  TextChat({
    required super.senderIndex,
    required super.dateTime,
    required this.text,
    this.replyIndex,
  }) : super(
          typeIndex: ChatType.text.index,
        );
  final int? replyIndex;
  final String text;
  @override
  List<Object?> get props => [
        index,
        dateTime,
        senderIndex,
        text,
        replyIndex,
      ];

  factory TextChat.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return TextChat(
      senderIndex: data["senderIndex"],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
      replyIndex: data["replyIndex"],
      text: data["text"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "senderIndex": senderIndex,
      "dateTime": dateTime.millisecondsSinceEpoch,
      "replyIndex": replyIndex,
      "text": text,
    };
  }

  TextChat copyWith({
    String? senderIndex,
    DateTime? dateTime,
    int? replyIndex,
    String? text,
  }) {
    return TextChat(
      senderIndex: senderIndex ?? this.senderIndex,
      dateTime: dateTime ?? this.dateTime,
      replyIndex: replyIndex ?? this.replyIndex,
      text: text ?? this.text,
    );
  }
}
