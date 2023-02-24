library public;

import 'package:equatable/equatable.dart';
part 'home_setting.dart';

class Public extends Equatable {
  const Public({
    required this.firstMeet,
    required this.homeSetting,
  });
  final DateTime firstMeet;
  final HomeSetting homeSetting;

  factory Public.empty() {
    return Public(
      firstMeet: DateTime.now(),
      homeSetting: HomeSetting.empty(),
    );
  }

  @override
  List<Object?> get props => [
        firstMeet,
        homeSetting,
      ];

  Map<String, dynamic> toMap() {
    return {
      "firstMeet": firstMeet.millisecondsSinceEpoch,
      "homeSetting": homeSetting.toMap(),
    };
  }

  factory Public.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return Public(
      firstMeet: DateTime.fromMillisecondsSinceEpoch(data["firstMeet"]),
      homeSetting: HomeSetting.fromMap(data["homeSetting"]),
    );
  }

  Public copyWith({
    DateTime? firstMeet,
    HomeSetting? homeSetting,
  }) {
    return Public(
      firstMeet: firstMeet ?? this.firstMeet,
      homeSetting: homeSetting ?? this.homeSetting,
    );
  }
}
