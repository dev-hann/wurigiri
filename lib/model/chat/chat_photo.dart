part of chat;

class PhotoChat extends Chat {
  PhotoChat({
    required super.senderIndex,
    required super.dateTime,
    required this.photoURL,
    required this.thumbData,
  }) : super(typeIndex: ChatType.photo.index);

  final String photoURL;
  final Uint8List thumbData;
  @override
  List<Object?> get props => [
        index,
        dateTime,
        senderIndex,
        photoURL,
      ];

  factory PhotoChat.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return PhotoChat(
      senderIndex: data["senderIndex"],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
      photoURL: data["photoURL"],
      thumbData: Uint8List.fromList(
        List<int>.from(data["thumbData"]),
      ),
    );
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "senderIndex": senderIndex,
      "dateTime": dateTime.millisecondsSinceEpoch,
      "photoURL": photoURL,
      "thumbData": thumbData.toList(),
    };
  }

  PhotoChat copyWith({
    String? senderIndex,
    DateTime? dateTime,
    String? photoURL,
    bool? isDeleted,
    Uint8List? thumbData,
  }) {
    return PhotoChat(
      senderIndex: senderIndex ?? this.senderIndex,
      dateTime: dateTime ?? this.dateTime,
      photoURL: photoURL ?? this.photoURL,
      thumbData: thumbData ?? this.thumbData,
    );
  }
}
