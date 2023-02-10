part of chat;

class SystemChat extends Chat {
  SystemChat({
    required super.senderIndex,
    required super.dateTime,
    required this.message,
    this.data,
  }) : super(typeIndex: ChatType.system.index);
  final String message;
  final dynamic data;
  @override
  List<Object?> get props => [
        index,
        dateTime,
        senderIndex,
        message,
      ];

  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "senderIndex": senderIndex,
      "dateTime": dateTime.millisecondsSinceEpoch,
      "message": message,
    };
  }

  factory SystemChat.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return SystemChat(
      senderIndex: data["senderIndex"],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
      message: data["message"],
    );
  }

  SystemChat copyWith({
    String? senderIndex,
    DateTime? dateTime,
    String? message,
  }) {
    return SystemChat(
      senderIndex: senderIndex ?? this.senderIndex,
      dateTime: dateTime ?? this.dateTime,
      message: message ?? this.message,
    );
  }
}
