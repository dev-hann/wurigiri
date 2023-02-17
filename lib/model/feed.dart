import 'package:equatable/equatable.dart';

class Feed extends Equatable with Comparable<Feed> {
  const Feed({
    required this.title,
    required this.dateTime,
    required this.photoList,
    required this.desc,
  });
  String get index => dateTime.millisecondsSinceEpoch.toString();
  final String title;
  final DateTime dateTime;
  final List<String> photoList;
  final String desc;
  @override
  List<Object?> get props => [index];

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "dateTime": dateTime.millisecondsSinceEpoch,
      "photoList": photoList,
      "desc": desc,
    };
  }

  factory Feed.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return Feed(
      title: data["title"],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
      photoList: List.from(data["photoList"]),
      desc: data["desc"],
    );
  }

  @override
  int compareTo(Feed other) {
    return other.index.compareTo(index);
  }
}
