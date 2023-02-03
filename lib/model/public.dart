import 'package:equatable/equatable.dart';

class Public extends Equatable {
  const Public({
    required this.mainPhoto,
    required this.feedList,
  });
  final String mainPhoto;
  final List<String> feedList;

  factory Public.empty() {
    return const Public(
      mainPhoto: "",
      feedList: [],
    );
  }

  @override
  List<Object?> get props => [
        mainPhoto,
        feedList,
      ];

  Map<String, dynamic> toMap() {
    return {
      "mainPhoto": mainPhoto,
      "feedList": feedList,
    };
  }

  factory Public.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return Public(
      mainPhoto: data["mainPhoto"],
      feedList: List<String>.from(data["feedList"]),
    );
  }

  Public copyWith({
    String? mainPhoto,
    List<String>? feedList,
  }) {
    return Public(
      mainPhoto: mainPhoto ?? this.mainPhoto,
      feedList: feedList ?? this.feedList,
    );
  }
}
