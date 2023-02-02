import 'package:equatable/equatable.dart';

class Notify extends Equatable {
  const Notify({
    required this.chat,
    required this.feed,
  });
  final int chat;
  final bool feed;

  factory Notify.empty() {
    return const Notify(chat: 0, feed: false);
  }

  @override
  List<Object?> get props => [
        chat,
        feed,
      ];

  factory Notify.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return Notify(
      chat: data["chat"],
      feed: data["feed"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "chat": chat,
      "feed": feed,
    };
  }

  Notify copyWith({
    int? chat,
    bool? feed,
  }) {
    return Notify(
      chat: chat ?? this.chat,
      feed: feed ?? this.feed,
    );
  }
}
