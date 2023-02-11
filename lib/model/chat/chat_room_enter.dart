import 'package:equatable/equatable.dart';

class ChatRoomEnter extends Equatable {
  const ChatRoomEnter({
    required this.userID,
    required this.dateTime,
  });
  final String userID;
  final DateTime dateTime;
  factory ChatRoomEnter.now(String userID) {
    return ChatRoomEnter(
      userID: userID,
      dateTime: DateTime.now(),
    );
  }
  @override
  List<Object?> get props => [
        userID,
        dateTime,
      ];

  factory ChatRoomEnter.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return ChatRoomEnter(
      userID: data["userID"],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      "dateTime": dateTime.millisecondsSinceEpoch,
    };
  }
}
