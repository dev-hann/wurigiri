import 'package:equatable/equatable.dart';

class Feed extends Equatable with Comparable<Feed> {
  const Feed({
    required this.dateTime,
    required this.title,
    required this.desc,
  });
  String get index => dateTime.millisecondsSinceEpoch.toString();
  final DateTime dateTime;
  final String title;
  final String desc;

  @override
  List<Object?> get props => [index];

  Map<String, dynamic> toMap() {
    return {
      "dateTime": dateTime.millisecondsSinceEpoch,
      "title": title,
      "desc": desc,
    };
  }

  factory Feed.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return Feed(
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
      title: data["title"],
      desc: data["desc"],
    );
  }

  @override
  int compareTo(Feed other) {
    return other.index.compareTo(index);
  }
}
