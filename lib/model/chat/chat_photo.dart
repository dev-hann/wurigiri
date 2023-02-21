part of chat;

class PhotoChat extends Chat {
  PhotoChat({
    required super.senderIndex,
    required super.dateTime,
    required this.photoList,
    required this.thumbList,
  }) : super(typeIndex: ChatType.photo.index);

  final List<String> photoList;
  final List<Uint8List> thumbList;
  @override
  List<Object?> get props => [
        index,
        dateTime,
        senderIndex,
        photoList,
      ];

  factory PhotoChat.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return PhotoChat(
      senderIndex: data["senderIndex"],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
      photoList: List<String>.from(data["photoURL"]),
      thumbList: List<Uint8List>.from(
        List<String>.from(data["thumbList"]).map((e) => base64Decode(e)),
      ),
    );
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "senderIndex": senderIndex,
      "dateTime": dateTime.millisecondsSinceEpoch,
      "photoURL": photoList.toList(),
      "thumbList": thumbList.map((e) => base64Encode(e)).toList(),
    };
  }

  PhotoChat copyWith({
    String? senderIndex,
    DateTime? dateTime,
    List<String>? photoList,
    List<Uint8List>? thumbList,
  }) {
    return PhotoChat(
      senderIndex: senderIndex ?? this.senderIndex,
      dateTime: dateTime ?? this.dateTime,
      photoList: photoList ?? this.photoList,
      thumbList: thumbList ?? this.thumbList,
    );
  }
}
