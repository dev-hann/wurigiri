part of chat;

class TextChat extends Chat {
  TextChat({
    required super.senderIndex,
    required super.dateTime,
    required this.text,
    super.isDeleted,
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
        isDeleted,
        text,
        replyIndex,
      ];

  factory TextChat.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return TextChat(
      senderIndex: data["senderIndex"],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
      isDeleted: data["isDeleted"],
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
      "isDeleted": isDeleted,
      "replyIndex": replyIndex,
      "text": text,
    };
  }

  @override
  TextChat copyWith({
    String? senderIndex,
    DateTime? dateTime,
    bool? isDeleted,
    int? replyIndex,
    String? text,
  }) {
    return TextChat(
      senderIndex: senderIndex ?? this.senderIndex,
      dateTime: dateTime ?? this.dateTime,
      isDeleted: isDeleted ?? this.isDeleted,
      replyIndex: replyIndex ?? this.replyIndex,
      text: text ?? this.text,
    );
  }
}
